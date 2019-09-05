# frozen_string_literal: true

module LessonFactory
  DEFAULT_LESSON_LENGTH = 60
  AVG_BLOCK_LENGTH = 4.seconds

  def self.create(langs, lesson_length = DEFAULT_LESSON_LENGTH, user = nil)
    return unless langs.present?
    return unless lesson_length.present? && lesson_length.positive?

    block_count = lesson_length / AVG_BLOCK_LENGTH

    ActiveRecord::Base.transaction do
      picked_sentences = []

      picked_sentences = SentencePicker.new(user, limit: block_count).picked_sentences if user.present?

      # user is not logged in, or fallback if sentence picker didn't return anything
      picked_sentences = Sentence.ready_for_lesson(limit: block_count).map(&:id) if picked_sentences.empty?

      lesson = Lesson.create!(user: user, target_language: langs.target_language)

      picked_sentences.each do |sentence|
        Block.create!(lesson: lesson, sentence_id: sentence, state: 'requested')
      end

      raise ActiveRecord::Rollback if lesson.blocks.empty?

      lesson
    end
  end
end
