# frozen_string_literal: true

class Langs
  attr_reader :base_lang, :target_lang

  def initialize(base_lang, target_lang)
    @base_lang = base_lang
    @target_lang = target_lang
  end

  def target_language
    Language.find_by(lang: @target_lang)
  end

  def base_language
    Language.find_by(lang: @base_lang)
  end
end
