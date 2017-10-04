class AddDataTypeToChatData < ActiveRecord::Migration[5.1]
  def change
    add_column :chat_data, :data_type, :string
  end
end
