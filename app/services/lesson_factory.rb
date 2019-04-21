# frozen_string_literal: true

module LessonFactory
  DEFAULT_LESSON_LENGTH = 60
  AVG_BLOCK_LENGTH = 4.seconds

  def self.create(langs, lesson_length = DEFAULT_LESSON_LENGTH, user = nil)
    return unless langs.present?
    return unless lesson_length.present? && lesson_length.positive?

    block_count = lesson_length / AVG_BLOCK_LENGTH

    ActiveRecord::Base.transaction do

      lesson = Lesson.create!(user: user, target_language: langs.target_language)

      Sentence.ready_for_lesson(limit: block_count).each do |sentence|
        Block.create!(lesson: lesson, sentence: sentence, state: 'requested')
      end

      raise ActiveRecord::Rollback if lesson.blocks.empty?

      lesson
    end
  end
end
