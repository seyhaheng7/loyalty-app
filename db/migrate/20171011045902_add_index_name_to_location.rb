class AddIndexNameToLocation < ActiveRecord::Migration[5.1]
  def change
    add_index :locations, :name
  end
end
