require "rails_helper"

describe Translation do

  let(:original) { create(:sentence) }

  context "with nl translation" do

    let(:nl_translation) { create(:translation, :nl, original: original) }

    describe '#language' do
      it 'returns Lnaguage object for nl' do
        expect(nl_translation.language.class.name).to eq('Language')
        expect(nl_translation.language.lang).to eq('nl')
      end
    end

    describe '#lang' do
      it 'returns nl' do
        expect(nl_translation.lang).to eq('nl')
      end
    end

    describe '#original' do
      it 'returns original sentence' do
        expect(nl_translation.original).to eq(original)
      end
    end
  end
end
