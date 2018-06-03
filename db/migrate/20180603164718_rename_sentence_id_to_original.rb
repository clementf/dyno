class RenameSentenceIdToOriginal < ActiveRecord::Migration[5.2]
  def change
    rename_column :translations, :sentence_id, :original_id
  end
end
