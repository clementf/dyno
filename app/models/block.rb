class Block < ApplicationRecord
  has_and_belongs_to_many :sessions
  belongs_to :translation
end
