# frozen_string_literal: true

require 'rails_helper'

describe SessionFactory do
  describe '#create' do
    let(:langs) { Langs.new('nl', 'en') }

    context 'when passing incorrect langs' do
      it 'return nil' do
        expect(SessionFactory.create([], 1)).to eq nil
      end
    end

    context 'wrong session legnth' do
      it 'return nil' do
        expect(SessionFactory.create(langs, 0)).to eq nil
      end

      it 'return nil' do
        expect(SessionFactory.create(langs, -1)).to eq nil
      end

      it 'return nil' do
        expect(SessionFactory.create(langs, nil)).to eq nil
      end
    end

    context 'when not passing session_length' do
      it 'return session with default length' do
        block_count = SessionFactory::DEFAULT_SESSION_LENGTH / SessionFactory::AVG_BLOCK_LENGTH

        expect(Block).to receive(:ready_for_session)
          .with(langs, limit: block_count)
          .and_return(build_list(:block, block_count))

        SessionFactory.create(langs)

        expect(Session.count).to eq 1
      end

      it 'get blocks to create the session' do
        block_count = SessionFactory::DEFAULT_SESSION_LENGTH / SessionFactory::AVG_BLOCK_LENGTH

        expect(Block).to receive(:ready_for_session)
          .with(langs, limit: block_count)
          .and_return(build_list(:block, block_count))

        SessionFactory.create(langs)
      end
    end

    context 'when passing all arguments' do
      it 'creates the session' do
        session_length = 22
        block_count = session_length / SessionFactory::AVG_BLOCK_LENGTH

        expect(Block).to receive(:ready_for_session)
          .with(langs, limit: block_count)
          .and_return(build_list(:block, block_count))

        SessionFactory.create(langs, session_length)
      end
    end
  end
end
