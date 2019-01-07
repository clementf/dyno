# frozen_string_literal: true

class Types::BlockType < GraphQL::Schema::Object
  graphql_name 'Block'
  description 'Represents a block'

  field :id, ID, null: false
  field :transcript, String, null: false
  field :audio, String, null: true

  def audio
    Rails.application.routes.url_helpers.rails_blob_path(@object.audio, only_path: true)
  end
end
