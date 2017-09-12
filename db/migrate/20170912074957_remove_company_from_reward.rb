class RemoveCompanyFromReward < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :rewards, :companies
    remove_column :rewards, :company_id
  end
end
