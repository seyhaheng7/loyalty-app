class AddDeletedAtToContactForm < ActiveRecord::Migration[5.1]
  def change
    add_column :contact_forms, :deleted_at, :datetime
    add_index :contact_forms, :deleted_at
  end
end
