# frozen_string_literal: true

require 'rails_helper'

describe Block do
  it { is_expected.to belong_to(:translation) }
  it { is_expected.to belong_to(:target_language) }
  it { is_expected.to have_and_belong_to_many(:sessions) }

  describe LanguageValidator do
    context 'when target and base language are different' do
      it 'block is valid' do
        block = build(:block)
        expect(block).to be_valid
      end
    end

    context 'when target and base language are the same' do
      it 'block is invalid' do
        nl_language = build(:language, :nl)
        block       = build(:block, target_language: nl_language)

        expect(block).to be_invalid
      end
    end
  end
end
