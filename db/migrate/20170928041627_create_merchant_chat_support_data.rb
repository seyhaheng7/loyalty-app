class CreateMerchantChatSupportData < ActiveRecord::Migration[5.1]
  def change
    create_table :merchant_chat_support_data do |t|
      t.text :text
      t.belongs_to :supportable, polymorphic: true, index: { name: 'index_merchant_chat_support_supportable' }
      t.references :merchant_chat_support, foreign_key: true

      t.timestamps
    end
  end
end
