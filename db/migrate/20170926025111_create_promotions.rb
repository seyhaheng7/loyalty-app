class CreatePromotions < ActiveRecord::Migration[5.1]
  def change
    create_table :promotions do |t|
      t.string :title
      t.string :image
      t.text :body
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
