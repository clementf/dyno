# frozen_string_literal: true

# == Schema Information
#
# Table name: lessons
#
#  id                 :bigint(8)        not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  target_language_id :bigint(8)
#  user_id            :bigint(8)
#
# Indexes
#
#  index_lessons_on_target_language_id  (target_language_id)
#  index_lessons_on_user_id             (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (target_language_id => languages.id)
#  fk_rails_...  (user_id => users.id)
#

class Lesson < ApplicationRecord
  has_and_belongs_to_many :blocks
  belongs_to :user, optional: true
  belongs_to :target_language, class_name: 'Language', foreign_key: 'target_language_id'

  alias language target_language
end
