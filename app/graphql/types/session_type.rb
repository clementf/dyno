# frozen_string_literal: true

class Types::SessionType < GraphQL::Schema::Object
  graphql_name 'Session'
  description 'Represents a session'

  field :id, ID, null: false
  field :blocks, [Types::BlockType], null: true

  def blocks
    @object.blocks
  end
end
