class CreateStickerGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :sticker_groups do |t|
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
