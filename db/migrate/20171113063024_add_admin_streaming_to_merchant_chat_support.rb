class AddAdminStreamingToMerchantChatSupport < ActiveRecord::Migration[5.1]
  def change
    add_column :merchant_chat_supports, :admin_streaming, :boolean, default: false
  end
end
