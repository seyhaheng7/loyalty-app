class AddIndexToStore < ActiveRecord::Migration[5.1]
  def change
    add_index :stores, :name
    add_index :stores, [:lat, :long]
  end
end
