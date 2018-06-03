class Sentence < ApplicationRecord
  include Translatable

  has_many :translations

  def language
    Language.find_or_create_by(lang: 'en')
  end

  def original
    self
  end
end
