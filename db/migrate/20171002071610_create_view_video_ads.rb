class CreateViewVideoAds < ActiveRecord::Migration[5.1]
  def change
    create_table :view_video_ads do |t|
      t.date :date
      t.integer :view_count, default: 0
      t.references :video_ad, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
