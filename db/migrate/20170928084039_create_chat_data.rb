class CreateChatData < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_data do |t|
      t.text :text
      t.boolean :all_recieved
      t.references :chat_room, foreign_key: true
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
