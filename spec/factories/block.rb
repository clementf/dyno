# frozen_string_literal: true

FactoryBot.define do
  factory :block do
    transcript 'Blauw means blue'
    translation
    association :target_language, factory: :language
  end
end
