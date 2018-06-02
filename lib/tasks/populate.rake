require 'csv'

namespace :populate do
  desc "Populate db with most common dutch word"
  task dutch: :environment do
    raise "Can't do it in production" if Rails.env.prod?

    dutch_language = Language.find_or_create_by(lang: 'nl')

    file_path = Rails.root.join('tmp', 'nl_en.csv')

    CSV.foreach(file_path) do |row|
      nl = row[0]
      en = row[1]

      en_sentence = Sentence.create(content: en)

      en_sentence.translations.create(language: dutch_language, content: nl)

    end
  end
end
