# frozen_string_literal: true

class RecapSenderJob < ApplicationJob
  queue_as :default

  def perform
    users_to_email = User.where(id: 2).pluck(:id)

    users_to_email.each do |user_id|
      RecapMailer.recap_for_user(user_id).deliver
    end
  end
end
