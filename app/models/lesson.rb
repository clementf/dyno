# frozen_string_literal: true

class Lesson < ApplicationRecord
  has_and_belongs_to_many :blocks
  belongs_to :user, optional: true
end
