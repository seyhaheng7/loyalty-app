class AddDeletedAtToRewards < ActiveRecord::Migration[5.1]
  def change
    add_column :rewards, :deleted_at, :datetime
    add_index :rewards, :deleted_at
  end
end
