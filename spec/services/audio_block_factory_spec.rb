# frozen_string_literal: true

require 'rails_helper'

describe TTS::AudioBlockFactory do
  let(:text_converter) { double('text_converter') }
  let(:block) { build(:block) }

  describe '#initialize' do
    context 'when not passing arguments' do
      it 'raises an exception' do
        expect do
          TTS::AudioBlockFactory.new
        end.to raise_error(ArgumentError)
      end
    end

    context 'when passing correct arguments' do
      it 'creates an object' do
        object = TTS::AudioBlockFactory.new(block: block, text_converter: text_converter)

        expect(object.class).to eq TTS::AudioBlockFactory
      end
    end
  end

  describe 'create' do
    let(:factory) { TTS::AudioBlockFactory.new(block: block, text_converter: text_converter) }

    it 'creates the audio for the base language part and target language part' do
      expect(text_converter).to receive(:to_audio).with(
        text: block.content_for_base_lang + ', is',
        lang: block.base_lang,
        filename: './tmp/blocks/_base_part.mp3'
      )

      expect(text_converter).to receive(:to_audio).with(
        text: block.content_for_target_lang,
        lang: block.target_lang,
        filename: './tmp/blocks/_target_part.mp3'
      )
      expect(TTS::MP3).to receive(:concatenate)
      expect(factory).to receive(:attach_file_to_block).and_return(true)

      factory.create
    end
  end
end
