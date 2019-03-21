# frozen_string_literal: true

# == Schema Information
#
# Table name: lessons
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_lessons_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class Lesson < ApplicationRecord
  has_and_belongs_to_many :blocks
  belongs_to :user, optional: true
end
