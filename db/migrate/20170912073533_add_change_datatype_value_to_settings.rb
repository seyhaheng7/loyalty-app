class AddChangeDatatypeValueToSettings < ActiveRecord::Migration[5.1]
  change_column :settings, :value, :string
end
