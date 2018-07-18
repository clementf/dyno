# frozen_string_literal: true

class Session < ApplicationRecord
  has_and_belongs_to_many :blocks

  # TODO: validate presence of at least one block

  DEFAULT_BLOCK_COUNT = 10
  AVG_BLOCK_LENGTH = 4.seconds

  def self.create_next(langs, session_length)
    return unless langs.present?
    return if session_length.present? && session_length.negative?

    block_count = session_length.present? ? session_length / AVG_BLOCK_LENGTH : DEFAULT_BLOCK_COUNT

    blocks = Block.with_audio
                  .with_langs(langs)
                  .order('RANDOM()')
                  .limit(block_count)

    Session.create(blocks: blocks)
  end
end
