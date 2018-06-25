class AddSentenceIdToBlock < ActiveRecord::Migration[5.2]
  def change
    add_reference :blocks, :sentence, index: true, foreign_key: true
  end
end
