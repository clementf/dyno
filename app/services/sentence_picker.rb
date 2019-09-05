# frozen_string_literal: true

class SentencePicker
  def initialize(user, limit:)
    @user = user
    @limit = limit
  end

  def picked_sentences
    # Algo to pick blocks:
    #
    # box 1: 1/3 of blocks that are known, but were studied a long time ago
    # If it fails, box 2 should have 2/3 of total blocks
    #
    # box 2: 1/3 of recently studied blocks, not yet known
    #
    # box 3: 1/3 of new content
    #
    # If fails to retrieve for box 2 or box 3, replace it by same amount of blocks, picked randomly

    old_sentences = old_blocks.map(&:sentence).map(&:id)
    not_yet_known_lesson_ids = count_lessons_per_sentence
                               .select { |_sentence_id, count| count < known_lesson_threshold }.keys

    sentences_studied_long_ago = Sentence.with_audio.where(id: old_sentences - all_new_sentences).map(&:id)
    sentences_not_yet_known    = Sentence.with_audio.where(id: not_yet_known_lesson_ids).map(&:id)
    new_sentences              = Sentence.with_audio.where.not(id: all_new_sentences + old_sentences).map(&:id).shuffle

    picked_sentences = []

    Rails.logger.info "sentences_studied_long_ago: #{sentences_studied_long_ago}"
    Rails.logger.info "sentences_not_yet_known: #{sentences_not_yet_known}"
    Rails.logger.info "new_sentences: #{new_sentences}"

    while picked_sentences.count < @limit
      break if sentences_not_yet_known.empty? && sentences_studied_long_ago.empty? && new_sentences.empty?

      picked_sentences << sentences_studied_long_ago.pop
      picked_sentences << sentences_not_yet_known.pop
      picked_sentences << new_sentences.pop
      picked_sentences.compact!
    end
    picked_sentences
  end

  private

  def old_blocks
    @old_blocks ||= Block.includes(:sentence)
                         .joins(:lesson)
                         .where('lessons.created_at < ? ', Time.now - old_lesson_threshold)
                         .where(lessons: { user: @user })
  end

  def new_blocks
    @new_blocks ||= Block.includes(:sentence)
                         .joins(:lesson)
                         .where('lessons.created_at > ? ', Time.now - old_lesson_threshold)
                         .where(lessons: { user: @user })
  end

  def count_lessons_per_sentence
    @count_lessons_per_sentence ||= Block.includes(:sentence)
                                         .joins(:lesson)
                                         .where(lessons: { user: @user })
                                         .where(sentences: { id: all_new_sentences })
                                         .group('sentence_id')
                                         .count
  end

  def all_new_sentences
    @all_new_sentences ||= new_blocks.map(&:sentence).map(&:id) || []
  end

  def known_lesson_threshold
    6
  end

  def old_lesson_threshold
    2.weeks
  end
end
