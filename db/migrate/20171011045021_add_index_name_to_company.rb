class AddIndexNameToCompany < ActiveRecord::Migration[5.1]
  def change
     add_index :companies, :name
  end
end
