# frozen_string_literal: true

class HermesSchema < GraphQL::Schema
  mutation Types::MutationType
  query Types::QueryType
end
