class AddIndexStartDateAndEndDateToPromotion < ActiveRecord::Migration[5.1]
  def change
    add_index :promotions, :start_date
    add_index :promotions, [:start_date, :end_date]
  end
end
