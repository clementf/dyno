# frozen_string_literal: true

module Translatable
  def lang
    language.lang
  end

  def translate_to(target_lang = 'en')
    target_language = Language.find_by(lang: target_lang)

    return self if target_language == language

    return original if target_lang == 'en'
    translations.where(language: target_language).first
  end
end
