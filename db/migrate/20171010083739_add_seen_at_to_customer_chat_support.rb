class AddSeenAtToCustomerChatSupport < ActiveRecord::Migration[5.1]
  def change
    add_column :customer_chat_supports, :seen_at, :datetime
  end
end
