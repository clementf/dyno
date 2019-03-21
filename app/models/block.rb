# frozen_string_literal: true

# == Schema Information
#
# Table name: blocks
#
#  id                 :bigint(8)        not null, primary key
#  transcript         :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  sentence_id        :bigint(8)
#  target_language_id :integer
#  translation_id     :bigint(8)
#
# Indexes
#
#  index_blocks_on_sentence_id         (sentence_id)
#  index_blocks_on_target_language_id  (target_language_id)
#  index_blocks_on_translation_id      (translation_id)
#
# Foreign Keys
#
#  fk_rails_...  (sentence_id => sentences.id)
#  fk_rails_...  (translation_id => translations.id)
#

class Block < ApplicationRecord
  has_one_attached :audio
  has_and_belongs_to_many :lessons
  belongs_to :translation, optional: true
  belongs_to :sentence, optional: true
  belongs_to :target_language, class_name:  'Language',
                               foreign_key: 'target_language_id'

  validates_with BlockValidator

  validates_uniqueness_of :translation_id, scope: :target_language, allow_nil: true
  validates_uniqueness_of :sentence_id,    scope: :target_language, allow_nil: true

  scope :with_audio, -> { joins(:audio_attachment).where.not(audio_attachment: nil) }

  def target_lang
    target_language.lang
  end

  def base
    translation || sentence
  end

  def base_lang
    base.lang
  end

  def content_for_base_lang
    base.content
  end

  def content_for_target_lang
    base.translate_to(target_lang).content
  end

  def create_audio
    AudioBlockFactoryJob.perform_later(self)
  end

  def self.ready_for_lesson(langs, limit:)
    with_audio
      .with_langs(langs)
      .order(Arel.sql('RANDOM()'))
      .limit(limit)
  end

  def self.with_langs(langs)
    target_language = langs.target_language

    if langs.base_lang == 'en'
      where(target_language: target_language,
            translation_id: nil)
    else
      joins(:translation).where('target_language':          target_language,
                                'translations.language_id': langs.base_language)

    end
  end
end
