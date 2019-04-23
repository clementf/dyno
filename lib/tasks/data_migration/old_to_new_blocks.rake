# frozen_string_literal: true

namespace :data_migration do
  desc 'Recreate blocks from history contained in old_blocks table'

  task old_to_new_blocks: :environment do
    class OldBlocks < ActiveRecord::Base; end

    class BlocksLesson < ActiveRecord::Base; end

    ActiveRecord::Base.transaction do
      # get old lessons with their blocks
      lessons = BlocksLesson.all.to_a.group_by(&:lesson_id)

      lessons.each do |grouped_lesson|
        # [1] contains the actual blocks that belong to that lesson
        #
        grouped_lesson[1].each do |block|
          new_lesson = Lesson.find(block.lesson_id)
          # just in case, update all target languages to Dutch
          new_lesson.update!(target_language: Language.find_by_lang('nl'))

          puts "Creating block for lesson #{new_lesson.id}"

          Block.create!(
            lesson: new_lesson,
            sentence_id: OldBlocks.find(block.block_id).sentence_id,
            created_at: new_lesson.created_at,
            updated_at: new_lesson.updated_at
          )
        end
      end
    end
  end
end
