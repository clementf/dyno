# frozen_string_literal: true

class Types::TranslatableType < GraphQL::Schema::Object
  graphql_name 'Translatable'
  description 'Represents an original sentence or its translation'

  field :content, String, null: true
  field :audio, String, null: true

  def audio
    Rails.application.routes.url_helpers.rails_blob_path(@object.audio, only_path: true)
  end
end
