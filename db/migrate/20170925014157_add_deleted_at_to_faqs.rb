class AddDeletedAtToFaqs < ActiveRecord::Migration[5.1]
  def change
    add_column :faqs, :deleted_at, :datetime
    add_index :faqs, :deleted_at
  end
end
