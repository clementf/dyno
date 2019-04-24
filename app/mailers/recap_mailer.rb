# frozen_string_literal: true

class RecapMailer < ApplicationMailer
  def recap_for_user(user_id)
    @user = User.find(user_id)

    @content = all_content_from_yesterday

    if @content.empty?
      logger.info("Recap is empty for user #{@user.id}")
      return
    end

    logger.info("Sending recap for user #{@user.id}")
    mail(to: @user.email, subject: 'Your recap from Yesterday')
  end

  private

  def all_content_from_yesterday
    blocks = Block.where(lesson: Lesson.from_yesterday.for_user(@user.id).pluck(:id))
                  .includes(:sentence)

    all_content = []
    blocks.each do |block|
      all_content << {
        sentence: block.sentence,
        translation: block.sentence.translate_to(block.lesson.target_language.lang)
      }
    end

    all_content
  end
end
