class ChangeWebSiteToWebsiteInAdvertisement < ActiveRecord::Migration[5.1]
  def change
    if column_exists?(:advertisements, :web_site)
      rename_column :advertisements, :web_site, :website
    end
  end
end
