# frozen_string_literal: true
# == Schema Information
#
# Table name: blocks
#
#  id          :bigint(8)        not null, primary key
#  state       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lesson_id   :bigint(8)
#  sentence_id :bigint(8)
#
# Indexes
#
#  index_blocks_on_lesson_id    (lesson_id)
#  index_blocks_on_sentence_id  (sentence_id)
#
# Foreign Keys
#
#  fk_rails_...  (lesson_id => lessons.id)
#  fk_rails_...  (sentence_id => sentences.id)
#

class Block < ApplicationRecord
  include AASM

  belongs_to :lesson
  belongs_to :sentence

  validates_uniqueness_of :sentence_id, scope: :lesson, allow_nil: false

  def target_lang
    lesson.target_language.lang
  end

  def translation
    sentence.translate_to(lesson.target_language.lang)
  end

  aasm column: :state do
    state :created, initial: true
    state :requested, :played

    event :request do
      transitions from: :created, to: :requested
    end

    event :play do
      transitions from: :requested, to: :played
    end
  end
end
