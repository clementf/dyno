# frozen_string_literal: true

class Translation < ApplicationRecord
  include Translatable

  belongs_to :original, class_name: 'Sentence'
  belongs_to :language
end
