# frozen_string_literal: true

class Types::BlockType < GraphQL::Schema::Object
  graphql_name 'Block'
  description 'Represents a block'

  field :id, ID, null: false
  field :original, Types::TranslatableType, null: true
  field :translation, Types::TranslatableType, null: true

  def original
    @object.sentence
  end

  def target
    @object.translation
  end
end
