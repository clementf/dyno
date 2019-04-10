# frozen_string_literal: true

module LessonFactory
  DEFAULT_LESSON_LENGTH = 60
  AVG_BLOCK_LENGTH = 4.seconds

  def self.create(langs, lesson_length = DEFAULT_LESSON_LENGTH, user = nil)
    return unless langs.present?
    return unless lesson_length.present? && lesson_length.positive?

    block_count = lesson_length / AVG_BLOCK_LENGTH

    blocks = Block.ready_for_lesson(langs, limit: block_count)

    return unless blocks.present?

    Lesson.create!(blocks: blocks, user: user, target_language: langs.target_language)
  end
end
