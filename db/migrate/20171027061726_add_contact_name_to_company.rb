class AddContactNameToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :contact_name, :string
  end
end
