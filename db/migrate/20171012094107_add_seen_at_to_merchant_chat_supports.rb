class AddSeenAtToMerchantChatSupports < ActiveRecord::Migration[5.1]
  def change
    add_column :merchant_chat_supports, :seen_at, :datetime
  end
end
