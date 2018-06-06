# frozen_string_literal: true

class LanguageValidator < ActiveModel::Validator
  def validate(record)
    if record.target_lang == record.base_lang
      record.errors[:language] << 'Base and target languages should be different'
    end
  end
end

class Block < ApplicationRecord
  has_and_belongs_to_many :sessions
  belongs_to :translation
  belongs_to :target_language, class_name: 'Language', foreign_key: 'target_language_id'

  validates_with LanguageValidator

  def target_lang
    target_language.lang
  end

  def base_lang
    translation.lang
  end
end
