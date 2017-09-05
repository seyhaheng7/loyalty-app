class CreateStickers < ActiveRecord::Migration[5.1]
  def change
    create_table :stickers do |t|
      t.string :name
      t.string :image
      t.references :sticker_group, foreign_key: true

      t.timestamps
    end
  end
end
