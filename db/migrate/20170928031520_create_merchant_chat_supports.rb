class CreateMerchantChatSupports < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_chat_supports do |t|
      t.references :merchant, foreign_key: true

      t.timestamps
    end
  end
end
