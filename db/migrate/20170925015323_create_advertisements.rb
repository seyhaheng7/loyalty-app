class CreateAdvertisements < ActiveRecord::Migration[5.1]
  def change
    create_table :advertisements do |t|
      t.string :name
      t.string :banner
      t.boolean :active
      t.string :for_page
      t.string :lat
      t.string :long
      t.string :address
      t.string :phone
      t.string :web_site
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
