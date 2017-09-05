class AddManagedByToReceipts < ActiveRecord::Migration[5.1]
  def change
    add_reference :receipts, :managed_by, references: :users
  end
end
