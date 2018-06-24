# frozen_string_literal: true

class Sentence < ApplicationRecord
  include Translatable

  def translations
    Translation.where(original: self)
  end

  def language
    Language.find_or_create_by(lang: 'en')
  end

  def original
    self
  end
end
