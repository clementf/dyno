# frozen_string_literal: true

class Session < ApplicationRecord
  has_and_belongs_to_many :blocks

  # TODO: validate presence of at least one block

  DEFAULT_SESSION_LENGTH = 60
  AVG_BLOCK_LENGTH = 4.seconds

  def self.create_next(langs, session_length = DEFAULT_SESSION_LENGTH)
    return unless langs.present?
    return unless session_length.present? && session_length.positive?

    block_count = session_length / AVG_BLOCK_LENGTH

    blocks = Block.ready_for_session(langs, limit: block_count)

    Session.create(blocks: blocks)
  end
end
