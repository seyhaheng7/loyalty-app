class CreateCustomerChatSupportData < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_chat_support_data do |t|
      t.text :text
      t.belongs_to :supportable, polymorphic: true, index: { name: 'index_customer_chat_support_supportable' }
      t.references :customer_chat_support, foreign_key: true

      t.timestamps
    end
  end
end
