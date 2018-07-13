# frozen_string_literal: true

class Session < ApplicationRecord
  has_and_belongs_to_many :blocks

  DEFAULT_SESSION_SIZE = 10

  def self.create_next(langs)
    blocks = Block.with_langs(langs).order(id: :asc).limit(DEFAULT_SESSION_SIZE)

    Session.create(blocks: blocks)
  end
end

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
