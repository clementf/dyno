class Block < ApplicationRecord
  has_and_belongs_to_many :sessions
  belongs_to :translation
  belongs_to :target_language, class_name: 'Language', foreign_key: 'target_language_id'
end
