class AddAdvertisementToBanner < ActiveRecord::Migration[5.1]
  def change
    add_reference :banners, :advertisement, foreign_key: true
  end
end
