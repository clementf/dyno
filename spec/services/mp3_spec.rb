# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/services/tts/mp3'

describe TTS::MP3 do
  describe '#concatenate' do
    let(:output_file) { 'spec/support/audio/spec_result.mp3' }

    after(:each) do
      FileUtils.rm(output_file)
    end

    it 'builds an mp3 file from two as input' do
      filepath1 = 'spec/support/audio/1_base_part.mp3'
      filepath2 = 'spec/support/audio/1_target_part.mp3'
      expected_output = 'spec/support/audio/1_complete.mp3'

      TTS::MP3.concatenate(filepath1, filepath2, output_file)

      expect(FileUtils.identical?(output_file, expected_output)).to eq true
    end
  end
end
