# frozen_string_literal: true

class DynoSchema < GraphQL::Schema
  mutation Types::MutationType
  query Types::QueryType
end
