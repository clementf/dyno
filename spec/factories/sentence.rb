# frozen_string_literal: true

FactoryBot.define do
  factory :sentence do
    content 'Content of the sentence'

    before(:create) do
      Language.find_or_create_by(lang: 'en')
    end
  end
end
