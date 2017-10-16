class AddAudioToChatData < ActiveRecord::Migration[5.1]
  def change
    add_column :chat_data, :audio, :string
  end
end
