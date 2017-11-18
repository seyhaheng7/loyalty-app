class AddTermAndConditionToStore < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :term_and_condition, :text
  end
end
