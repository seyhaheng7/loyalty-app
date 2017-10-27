class AddEmailToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :email, :string
  end
end
