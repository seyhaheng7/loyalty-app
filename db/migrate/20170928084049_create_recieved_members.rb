class CreateRecievedMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :recieved_members do |t|
      t.references :chat_datum, foreign_key: true
      t.references :chat_member, foreign_key: true

      t.timestamps
    end
  end
end
