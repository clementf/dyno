# frozen_string_literal: true

class Block < ApplicationRecord
  has_and_belongs_to_many :sessions
  belongs_to :translation, optional: true
  belongs_to :sentence, optional: true
  belongs_to :target_language, class_name:  'Language',
                               foreign_key: 'target_language_id'

  validates_with LanguageValidator

  validates_uniqueness_of :translation_id, scope: :target_language, allow_nil: true
  validates_uniqueness_of :sentence_id,    scope: :target_language, allow_nil: true

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
end
