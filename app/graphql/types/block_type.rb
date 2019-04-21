# frozen_string_literal: true

class Types::BlockType < GraphQL::Schema::Object
  graphql_name 'Block'
  description 'Represents a block'

  field :id, ID, null: false
  field :original_audio, String, null: true
  field :target_audio, String, null: true

  def original_audio
    audio_path(@object.sentence)
  end

  def target_audio
    audio_path(@object.translation)
  end

  private

  def audio_path(translatable)
    Rails.application.routes.url_helpers.rails_blob_path(translatable.audio, only_path: true)
  end
end
