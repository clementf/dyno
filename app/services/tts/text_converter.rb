require 'aws-sdk-polly'

module TTS

  LANGUAGE_VOICE_MAPPING = {
    nl: 'Ruben',
  }.with_indifferent_access

  class TextConverter

    def initialize
      @client = Aws::Polly::Client.new(region: ENV['AWS_REGION'])
    end

    def to_audio(text:, lang:, filename:)
      begin

        @client.synthesize_speech(
          response_target: filename,
          text: text,
          output_format: "mp3",
          voice_id: TTS::LANGUAGE_VOICE_MAPPING[lang]
        )

      rescue Aws::Polly::Errors::ServiceError

      end
    end
  end
end
