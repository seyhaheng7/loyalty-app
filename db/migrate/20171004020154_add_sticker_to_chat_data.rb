class AddStickerToChatData < ActiveRecord::Migration[5.1]
  def change
    add_column :chat_data, :sticker, :string
  end
end
