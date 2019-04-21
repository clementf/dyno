class RecreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.belongs_to :lesson, index: true, foreign_key: true
      t.references :sentence, index: true, foreign_key: true
      t.string :state
      t.timestamps
    end
  end
end
