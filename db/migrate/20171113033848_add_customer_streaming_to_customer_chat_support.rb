class AddCustomerStreamingToCustomerChatSupport < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_chat_supports, :customer_streaming, :boolean, default: false
  end
end
