# frozen_string_literal: true

FactoryBot.define do
  factory :translation do
    sequence :content do |n|
      "Content of the translation #{n}"
    end

    association :original, factory: :sentence

    transient do
      lang 'nl'
    end

    before(:create) do |translation, evaluator|
      if evaluator.lang.present?
        language = Language.find_or_create_by(lang: evaluator.lang)
        translation.language = language
      end
    end

    trait :nl do
      transient do
        lang 'nl'
      end
    end
  end
end
