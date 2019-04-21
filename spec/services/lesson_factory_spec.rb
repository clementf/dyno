# frozen_string_literal: true

require 'rails_helper'

describe LessonFactory do
  describe '#create' do
    let(:langs) do
      create(:language)
      create(:language, :nl)
      Langs.new('en', 'nl')
    end

    context 'when passing incorrect langs' do
      it 'return nil' do
        expect(LessonFactory.create([], 1)).to eq nil
      end
    end

    context 'wrong lesson length' do
      it 'return nil' do
        expect(LessonFactory.create(langs, 0)).to eq nil
      end

      it 'return nil' do
        expect(LessonFactory.create(langs, -1)).to eq nil
      end

      it 'return nil' do
        expect(LessonFactory.create(langs, nil)).to eq nil
      end
    end

    context 'when not passing lesson' do
      it 'return lesson with default length' do
        block_count = LessonFactory::DEFAULT_LESSON_LENGTH / LessonFactory::AVG_BLOCK_LENGTH

        expect(Sentence).to receive(:ready_for_lesson)
          .with(limit: block_count)
          .and_return(build_list(:sentence, block_count))

        LessonFactory.create(langs)

        expect(Lesson.count).to eq 1
      end

      it 'creates blocks needed for lesson' do
        block_count = LessonFactory::DEFAULT_LESSON_LENGTH / LessonFactory::AVG_BLOCK_LENGTH

        expect(Sentence).to receive(:ready_for_lesson)
          .with(limit: block_count)
          .and_return(build_list(:sentence, block_count))

        LessonFactory.create(langs)

        expect(Block.count).to eq(block_count)
      end
    end

    context 'when passing all arguments' do
      it 'creates the lesson' do
        lesson_length = 22
        block_count = lesson_length / LessonFactory::AVG_BLOCK_LENGTH

        expect(Sentence).to receive(:ready_for_lesson)
          .with(limit: block_count)
          .and_return(build_list(:sentence, block_count))

        LessonFactory.create(langs, lesson_length)
      end
    end
  end
end
