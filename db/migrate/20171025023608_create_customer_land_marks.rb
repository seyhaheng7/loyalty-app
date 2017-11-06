class CreateCustomerLandMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_land_marks do |t|
      t.float :lat
      t.float :long
      t.references :land_mark, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
