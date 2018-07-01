# frozen_string_literal: true

class AudioBlockFactoryJob < ApplicationJob
  queue_as :default

  def perform(block)
    audio_factory = TTS::AudioBlockFactory.new(
      block: block,
      text_converter: TTS::TextConverter.new
    )

    audio_factory.create
  end
end
