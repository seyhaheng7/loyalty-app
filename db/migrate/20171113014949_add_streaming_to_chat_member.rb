class AddStreamingToChatMember < ActiveRecord::Migration[5.1]
  def change
    add_column :chat_members, :streaming, :boolean, default: false
  end
end
