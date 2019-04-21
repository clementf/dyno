# frozen_string_literal: true

module Translatable
  extend ActiveSupport::Concern

  included do
    has_one_attached :audio
  end

  def lang
    language.lang
  end

  def create_audio
    AudioTranslatableFactoryJob.perform_later(self)
  end

  def translate_to(target_lang = 'en')
    target_language = Language.find_by(lang: target_lang)

    return self if target_language == language

    return original if target_lang == 'en'
    translations.where(language: target_language).first
  end
end
