class RenameSessions < ActiveRecord::Migration[5.2]
  def change
    rename_table :sessions, :lessons
    rename_table :blocks_sessions, :blocks_lessons

    rename_column :blocks_lessons, :session_id, :lesson_id
  end
end
