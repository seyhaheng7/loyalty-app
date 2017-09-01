class AddPartnerToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :partner, :boolean, default: false
  end
end
