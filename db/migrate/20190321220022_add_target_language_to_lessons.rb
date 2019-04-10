class AddTargetLanguageToLessons < ActiveRecord::Migration[5.2]
  def change
    add_reference :lessons, :target_language, index: true, foreign_key: { to_table: :languages }
  end
end
