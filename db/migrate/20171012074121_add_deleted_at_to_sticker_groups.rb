class AddDeletedAtToStickerGroups < ActiveRecord::Migration[5.1]
  def change
    add_column :sticker_groups, :deleted_at, :datetime
    add_index :sticker_groups, :deleted_at
  end
end
