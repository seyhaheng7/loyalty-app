class AddIndexToRecieptCreatedAt < ActiveRecord::Migration[5.1]
  def change
    add_index :receipts, :created_at
  end
end
