# frozen_string_literal: true

module TTS
  class AudioTranslatableFactory
    OUTPUT_FOLDER = './tmp/audio/'

    def initialize(translatable:, text_converter: TTS::TextConverter.new)
      @translatable   = translatable
      @text_converter = text_converter

      create_folder_if_needed
    end

    def create_audio
      filename = "#{@translatable.class.name.downcase}_#{@translatable.id}.mp3"
      output_filepath = File.join(OUTPUT_FOLDER, filename)

      @text_converter.to_audio(text: @translatable.content,
                               lang: @translatable.lang,
                               output_filepath: output_filepath)
      @translatable.audio.attach(
        io:       File.open(output_filepath),
        filename: filename
      )
    end

    private

    def create_folder_if_needed
      FileUtils.mkdir_p(OUTPUT_FOLDER) unless File.exist?(OUTPUT_FOLDER)
    end
  end
end
