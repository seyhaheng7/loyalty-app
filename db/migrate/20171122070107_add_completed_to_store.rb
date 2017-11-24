class AddCompletedToStore < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :completed, :boolean, default: true
  end
end
