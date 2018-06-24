# frozen_string_literal: true

require 'rails_helper'

describe Translatable do
  let!(:english) { create(:sentence) }
  let!(:nl_translation) { create(:translation, :nl, original: english) }

  describe '#lang' do
    context 'with an english sentence' do
      it 'returns en' do
        expect(english.lang).to eq('en')
      end
    end

    context 'with a dutch translation' do
      it 'returns nl' do
        expect(nl_translation.lang).to eq('nl')
      end
    end
  end

  describe '#translate_to' do
    context 'default translation language is english' do
      it 'returns english translation' do
        expect(nl_translation.translate_to).to eq(english)
      end
    end

    context 'translating english to dutch' do
      it 'returns correct translation' do
        expect(english.translate_to('nl')).to eq(nl_translation)
      end
    end

    context 'translating dutch to english' do
      it 'returns correct translation' do
        expect(nl_translation.translate_to('en')).to eq(english)
      end
    end

    context 'trying translating dutch to dutch' do
      it 'returns itself' do
        expect(nl_translation.translate_to('nl')).to eq(nl_translation)
      end
    end
  end
end
