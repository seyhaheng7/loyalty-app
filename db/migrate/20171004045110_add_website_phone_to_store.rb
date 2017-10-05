class AddWebsitePhoneToStore < ActiveRecord::Migration[5.1]
  def change
    add_column :stores, :website, :string
    add_column :stores, :phone, :string
  end
end
