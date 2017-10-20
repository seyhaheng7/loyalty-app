class CreateStoreImages < ActiveRecord::Migration[5.1]
  
  def change
    create_table :store_images do |t|
      t.string :name
      t.references :imageable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end

end
