# frozen_string_literal: true

class Types::QueryType < GraphQL::Schema::Object
  graphql_name 'Query'

  field :next_session, Types::SessionType, null: true do
    description 'Find the next session'
  end

  def next_session(**_args)
    Session.take(1).first
  end
end
