class AddThumbnailToGuide < ActiveRecord::Migration[5.1]
  def change
    add_column :guides, :thumbnail, :string
  end
end
