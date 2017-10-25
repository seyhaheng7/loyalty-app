class CreateBanners < ActiveRecord::Migration[5.1]
  def change
    create_table :banners do |t|
      t.string :image

      t.references :imageable, polymorphic: true, index: true
      t.timestamps null: false

    end
  end
end
