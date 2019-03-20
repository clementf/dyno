# frozen_string_literal: true

class Types::QueryType < GraphQL::Schema::Object
  graphql_name 'Query'

  field :next_lesson, Types::LessonType, null: true do
    description 'Find the next lesson'
    argument :length, Integer, required: false
  end

  def next_lesson(**args)
    default_langs = Langs.new('en', 'nl')

    LessonFactory.create(default_langs, args[:length], @context[:current_user])
  end
end
