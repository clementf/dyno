class RenameBlocksToOldBlocks < ActiveRecord::Migration[5.2]
  def change
    rename_table :blocks, :old_blocks
  end
end
