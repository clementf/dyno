# frozen_string_literal: true

require 'aws-sdk-polly'

module TTS
  LANGUAGE_VOICE_MAPPING = {
    nl: 'Ruben',
    en: 'Matthew'
  }.with_indifferent_access

  class TextConverter
    def initialize(client = Aws::Polly::Client.new(region: ENV['AWS_REGION']))
      @client = client
    end

    def to_audio(text:, lang:, output_filepath:)
      @client.synthesize_speech(
        response_target: output_filepath,
        text: text,
        output_format: 'mp3',
        voice_id: TTS::LANGUAGE_VOICE_MAPPING[lang]
      )
    rescue Aws::Polly::Errors::ServiceError
    end
  end
end
