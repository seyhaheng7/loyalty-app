class CreateVideoAds < ActiveRecord::Migration[5.1]
  def change
    create_table :video_ads do |t|
      t.string :title
      t.string :video
      t.date :start_date
      t.date :end_date
      t.integer :earned_points

      t.timestamps
    end
  end
end
