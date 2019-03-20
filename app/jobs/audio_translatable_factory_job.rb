# frozen_string_literal: true

class AudioTranslatableFactoryJob < ApplicationJob
  queue_as :default

  def perform(translatable)
    TTS::AudioTranslatableFactory.new(translatable: translatable).create_audio
  end
end
