class CustomerChatSupportDatum < ApplicationRecord
  belongs_to :customer_chat_support
  belongs_to :supportable, polymorphic: true

  after_commit :broadcast_new_message
  after_commit :set_unseen

  private
    def broadcast_new_message
      ActionCable.server.broadcast "customer_chat_support_channel_#{customer_chat_support.id}", chat_datum: as_json, action: 'speak'
    end

    def set_unseen
      if supportable_type == "Customer"
        customer_chat_support.set_seen_at_to_blank
      end
    end
end
