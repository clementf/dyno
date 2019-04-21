# frozen_string_literal: true

# == Schema Information
#
# Table name: sentences
#
#  id         :bigint(8)        not null, primary key
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sentence < ApplicationRecord
  include Translatable

  validates_uniqueness_of :content, allow_nil: false

  scope :with_audio, -> { joins(:audio_attachment).where.not(audio_attachment: nil) }

  def translations
    Translation.where(original: self)
  end

  def language
    Language.find_or_create_by(lang: 'en')
  end

  def original
    self
  end

  def self.ready_for_lesson(limit:)
    # TODO: check that translation has audio
    with_audio
      .limit(limit)
      .order(Arel.sql('RANDOM()'))
  end
end
