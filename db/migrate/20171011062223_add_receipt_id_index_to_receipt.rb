class AddReceiptIdIndexToReceipt < ActiveRecord::Migration[5.1]
  def change
    add_index :receipts, :status
  end
end
