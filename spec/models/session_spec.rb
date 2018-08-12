# frozen_string_literal: true

require 'rails_helper'

describe Session do
  it { is_expected.to have_and_belong_to_many(:blocks) }

  describe '#create_next' do
    let(:langs) { Langs.new('nl', 'en') }

    context 'when passing incorrect langs' do
      it 'return nil' do
        expect(Session.create_next([], 1)).to eq nil
      end
    end

    context 'wrong session legnth' do
      it 'return nil' do
        expect(Session.create_next(langs, 0)).to eq nil
      end

      it 'return nil' do
        expect(Session.create_next(langs, -1)).to eq nil
      end

      it 'return nil' do
        expect(Session.create_next(langs, nil)).to eq nil
      end
    end

    context 'when not passing session_length' do
      it 'return session with default length' do
        Session.create_next(langs)

        expect(Session.count).to eq 1
      end

      it 'get blocks to create the session' do
        block_count = Session::DEFAULT_SESSION_LENGTH / Session::AVG_BLOCK_LENGTH

        expect(Block).to receive(:ready_for_session)
          .with(langs, limit: block_count)
          .and_return(build_list(:block, block_count))

        Session.create_next(langs)
      end
    end

    context 'when passing all arguments' do
      it 'creates the session' do
        session_length = 22
        block_count = session_length / Session::AVG_BLOCK_LENGTH

        expect(Block).to receive(:ready_for_session)
          .with(langs, limit: block_count)
          .and_return(build_list(:block, block_count))

        Session.create_next(langs, session_length)
      end
    end
  end
end
