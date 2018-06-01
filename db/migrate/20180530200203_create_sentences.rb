class CreateSentences < ActiveRecord::Migration[5.2]
  def change
    create_table :sentences do |t|
      t.string :content
      t.timestamps
    end

    create_table :languages do |t|
      t.string :lang
      t.timestamps
    end

    create_table :translations do |t|
      t.belongs_to :sentence, foreign_key: true
      t.references :language, foreign_key: true
      t.string :content
      t.timestamps
    end
  end
end
