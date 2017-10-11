class AddIndexDeviceIdToDevice < ActiveRecord::Migration[5.1]
  def change
    add_index :devices, :device_id
  end
end
