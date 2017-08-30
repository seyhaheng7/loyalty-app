class AddDeletedAtToReceipts < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :deleted_at, :datetime
    add_index :receipts, :deleted_at
  end
end
