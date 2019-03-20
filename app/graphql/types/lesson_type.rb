# frozen_string_literal: true

class Types::LessonType < GraphQL::Schema::Object
  graphql_name 'Lesson'
  description 'Represents a lesson'

  field :id, ID, null: false
  field :blocks, [Types::BlockType], null: true

  def blocks
    @object.blocks
  end
end
