class AddAdminStreamingToCustomerChatSupport < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_chat_supports, :admin_streaming, :boolean, default: false
  end
end
