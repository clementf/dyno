class CreateSession < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.timestamps
    end

    create_table :blocks do |t|
      t.string :transcript
      t.belongs_to :translation, index: true, foreign_key: true
      t.timestamps
    end

    create_table :blocks_sessions, id: false do |t|
      t.belongs_to :session, index: true
      t.belongs_to :block, index: true
    end
  end
end
