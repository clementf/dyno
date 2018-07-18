# frozen_string_literal: true

class Session < ApplicationRecord
  has_and_belongs_to_many :blocks

  # TODO: validate presence of at least one block

  DEFAULT_BLOCK_COUNT = 10

  def self.create_next(langs, block_count)
    return unless langs.present?

    block_count ||= DEFAULT_BLOCK_COUNT

    blocks = Block.with_audio
                  .with_langs(langs)
                  .order(id: :asc)
                  .limit(block_count)

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
