class Translation < ApplicationRecord
  belongs_to :sentence
  belongs_to :language
end
