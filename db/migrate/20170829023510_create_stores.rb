class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.float :lat
      t.float :long
      t.string :address
      t.references :company, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
