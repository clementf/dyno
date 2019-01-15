# frozen_string_literal: true

FactoryBot.define do
  factory :sentence do
    sequence :content do |n|
      "Content of the sentence #{n}"
    end

    before(:create) do
      Language.find_or_create_by(lang: 'en')
    end
  end
end
