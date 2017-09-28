class CreateGuides < ActiveRecord::Migration[5.1]
  def change
    create_table :guides do |t|
      t.string :title
      t.string :youtube_url

      t.timestamps
    end
  end
end
