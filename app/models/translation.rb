# frozen_string_literal: true

# == Schema Information
#
# Table name: translations
#
#  id          :bigint(8)        not null, primary key
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  language_id :bigint(8)
#  original_id :bigint(8)
#
# Indexes
#
#  index_translations_on_language_id  (language_id)
#  index_translations_on_original_id  (original_id)
#
# Foreign Keys
#
#  fk_rails_...  (language_id => languages.id)
#  fk_rails_...  (original_id => sentences.id)
#

class Translation < ApplicationRecord
  include Translatable

  belongs_to :original, class_name: 'Sentence'
  belongs_to :language

  validates_uniqueness_of :original, scope: :language, allow_nil: false
end
