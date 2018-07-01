# frozen_string_literal: true

module TTS
  class AudioBlockFactory
    BLOCK_OUTPUT_FOLDER = './tmp/blocks/'

    def initialize(block:, text_converter:)
      @block          = block
      @text_converter = text_converter
      @base_file_path = BLOCK_OUTPUT_FOLDER + @block.id.to_s

      create_folder_if_needed
    end

    def create
      output_filepath = @base_file_path + '_complete.mp3'
      create_audio_base_lang
      create_audio_target_lang

      audio_block_file_path = TTS::MP3.concatenate(base_lang_audio_filepath,
                                                   target_lang_audio_filepath,
                                                   output_filepath)

      attach_file_to_block(audio_block_file_path)
    end

    def attach_file_to_block(audio_block_file_path)
      @block.audio.attach(
        io:       File.open(audio_block_file_path),
        filename: "block_#{@block.id}.mp3"
      )
    end

    private

    def create_folder_if_needed
      FileUtils.mkdir_p(BLOCK_OUTPUT_FOLDER)
    end

    def create_audio_base_lang
      text = @block.content_for_base_lang + 'is'

      @text_converter.to_audio(text: text,
                               lang: @block.base_lang,
                               filename: base_lang_audio_filepath)
    end

    def create_audio_target_lang
      text = @block.content_for_target_lang

      @text_converter.to_audio(text: text,
                               lang: @block.target_lang,
                               filename: target_lang_audio_filepath)
    end

    def base_lang_audio_filepath
      "#{@base_file_path}_base_part.mp3"
    end

    def target_lang_audio_filepath
      "#{@base_file_path}_target_part.mp3"
    end
  end
end
