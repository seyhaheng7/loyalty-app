class AddDeletedAtToCustomer < ActiveRecord::Migration[5.1]
  def change
    if column_exists?(:customers, :deleted_at)
      add_column :customers, :deleted_at, :datetime
    end
  end
end
