class AddSetStatusDefaultValueToReceipts < ActiveRecord::Migration[5.1]
  def up
    change_column :receipts, :status, :string, default: "submitted"
  end

  def down
    change_column :receipts, :status, :string, default: nil
  end
end
