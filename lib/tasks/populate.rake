# frozen_string_literal: true

require 'csv'

namespace :populate do
  desc 'Populate db with most common dutch word'
  task dutch: :environment do
    raise 'Can\'t do it in production' if Rails.env.prod?

    dutch_language = Language.find_or_create_by(lang: 'nl')
    en_language = Language.find_or_create_by(lang: 'en')

    file_path = Rails.root.join('tmp', 'nl_en.csv')

    CSV.foreach(file_path) do |row|
      nl = row[0].downcase
      en = row[1].downcase
      min_size = 2

      if en.size <= min_size && nl.size <= min_size
        puts "Skipping #{en}"
        next
      end

      en_sentence = Sentence.create(content: en)

      en_sentence.translations.create(language: dutch_language, content: nl)
    end
  end
end
