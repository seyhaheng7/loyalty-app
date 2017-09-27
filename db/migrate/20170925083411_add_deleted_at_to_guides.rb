class AddDeletedAtToGuides < ActiveRecord::Migration[5.1]
  def change
    add_column :guides, :deleted_at, :datetime
    add_index :guides, :deleted_at
  end
end
