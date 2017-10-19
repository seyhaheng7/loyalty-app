class AddSortOrderToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :sort_order, :integer, default: 0
  end
end
