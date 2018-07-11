# frozen_string_literal: true

include Rails.application.routes.url_helpers

class Types::BlockType < GraphQL::Schema::Object
  graphql_name 'Block'
  description 'Represents a block'

  field :id, ID, null: false
  field :transcript, String, null: false
  field :audio, String, null: true

  def audio
    rails_blob_path(@object.audio, only_path: true)
  end
end
