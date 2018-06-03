require "rails_helper"

describe Translation do

  let(:original) { create(:sentence) }

  context "with nl translation" do

    let(:nl_translation) { create(:translation, :nl, original: original) }

    describe '#language' do
      it 'returns nl' do
        expect(nl_translation.lang).to eq('nl')
      end
    end

    describe '#lang' do
      it 'returns nl' do
        expect(nl_translation.lang).to eq('nl')
      end
    end
  end
end
