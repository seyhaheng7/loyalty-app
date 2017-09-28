class CreateCustomerChatSupports < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_chat_supports do |t|
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
