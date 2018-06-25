# frozen_string_literal: true

class Block < ApplicationRecord
  has_and_belongs_to_many :sessions
  belongs_to :translation, optional: true
  belongs_to :sentence, optional: true
  belongs_to :target_language, class_name:  'Language',
                               foreign_key: 'target_language_id'

  validates_with LanguageValidator

  def target_lang
    target_language.lang
  end

  def base_lang
    translation.lang
  end
end
