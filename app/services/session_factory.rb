# frozen_string_literal: true

module SessionFactory
  DEFAULT_SESSION_LENGTH = 60
  AVG_BLOCK_LENGTH = 4.seconds

  def self.create(langs, session_length = DEFAULT_SESSION_LENGTH, user = nil)
    return unless langs.present?
    return unless session_length.present? && session_length.positive?

    block_count = session_length / AVG_BLOCK_LENGTH

    blocks = Block.ready_for_session(langs, limit: block_count)

    return unless blocks.present?

    Session.create(blocks: blocks, user: user)
  end
end
