# frozen_string_literal: true

module BlockFactory
  def self.create(translatable:, target_lang:)
    transcript = "#{translatable.content} is #{translatable.translate_to(target_lang).content}"
    target_language = Language.find_by(lang: target_lang)

    params = {
      transcript: transcript,
      target_language: target_language
    }.merge(translatable_params(translatable))

    Block.create!(params)
  end

  def self.translatable_params(translatable)
    translatable_params = {}
    translatable_params[:translation] = Translation.find(translatable.id) if translatable.is_a?(Translation)
    translatable_params[:sentence]    = Sentence.find(translatable.id) if translatable.is_a?(Sentence)
    translatable_params
  end
end
