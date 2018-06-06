# frozen_string_literal: true

FactoryBot.define do
  factory :language do
    transient do
      lang 'en'
    end

    after(:build) do |language, evaluator|
      language.lang = evaluator.lang if evaluator.lang.present?
    end

    trait :nl do
      transient do
        lang 'nl'
      end
    end
  end
end
