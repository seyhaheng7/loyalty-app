class ChangeColumnAudioDataTypeStringToText < ActiveRecord::Migration[5.1]
  def change
    change_column :chat_data, :audio, :text
  end
end
