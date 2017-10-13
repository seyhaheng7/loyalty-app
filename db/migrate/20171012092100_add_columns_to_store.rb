class AddColumnsToStore < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :email, :string
    add_column :stores, :facebook, :string
    add_column :stores, :open_and_close, :string
  end
end
