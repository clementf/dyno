# frozen_string_literal: true

require 'rails_helper'

describe TTS::TextConverter do
  describe 'Language mapping' do
    it 'contains supported languages' do
      expect(TTS::LANGUAGE_VOICE_MAPPING.keys).to include('nl', 'en')
    end
  end

  describe '#to_audio' do
    let(:params) do
      {
        text: 'example',
        lang: 'nl',
        output_filepath: 'dummy/path'
      }
    end

    context 'without arguments' do
      it 'raises an exception' do
        expect do
          TTS::TextConverter.new.to_audio
        end.to raise_error(ArgumentError)
      end
    end

    context 'with arguments text, lang and output_file_path' do
      it 'does not raise an exception' do
        aws_client_double = double('aws-client')
        allow(aws_client_double).to receive(:synthesize_speech)

        expect do
          TTS::TextConverter
            .new(aws_client_double)
            .to_audio(params)
        end.not_to raise_error
      end

      it 'makes a call to the aws api' do
        aws_client_double = double('aws-client')
        expect(aws_client_double)
          .to receive(:synthesize_speech)
          .with(
            response_target: params[:output_filepath],
            text: params[:text],
            output_format: 'mp3',
            voice_id: 'Ruben'
          )

        TTS::TextConverter
          .new(aws_client_double)
          .to_audio(params)
      end
    end
  end
end
