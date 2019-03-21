# frozen_string_literal: true

# == Schema Information
#
# Table name: languages
#
#  id         :bigint(8)        not null, primary key
#  lang       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Language < ApplicationRecord
end
