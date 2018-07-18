# frozen_string_literal: true

class Session < ApplicationRecord
  has_and_belongs_to_many :blocks

  # TODO: validate presence of at least one block

  DEFAULT_BLOCK_COUNT = 10

  def self.create_next(langs, block_count = DEFAULT_BLOCK_COUNT)
    return unless langs.present?

    blocks = Block.with_audio
                  .with_langs(langs)
                  .order('RANDOM()')
                  .limit(block_count)

    Session.create(blocks: blocks)
  end
end
