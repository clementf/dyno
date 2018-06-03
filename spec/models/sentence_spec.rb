require "rails_helper"

describe Sentence do

  let(:sentence) { create(:sentence) }

  describe '#language' do
    it 'returns Language object for en' do
      expect(sentence.language.class.name).to eq('Language')
      expect(sentence.language.lang).to eq('en')
    end
  end

  describe '#lang' do
    it 'returns en' do
      expect(sentence.lang).to eq('en')
    end
  end

  describe '#original' do
    it 'returns itself' do
      expect(sentence.original).to eq(sentence)
    end
  end
end
