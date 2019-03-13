# frozen_string_literal: true

class Types::QueryType < GraphQL::Schema::Object
  graphql_name 'Query'

  field :next_session, Types::SessionType, null: true do
    description 'Find the next session'
    argument :length, Integer, required: false
  end

  def next_session(**args)
    default_langs = Langs.new('en', 'nl')

    SessionFactory.create(default_langs, args[:length], @context[:current_user])
  end
end
