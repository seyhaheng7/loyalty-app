class CustomerChatSupportDatum < ApplicationRecord
  belongs_to :customer_chat_support
  belongs_to :supportable, polymorphic: true

  after_save :broadcast_new_message
  after_save :set_unseen
  after_save :notify_offline_member

  validates :text, presence: true

  private
    def notify_offline_member
      CustomerChatSupportDatumNotificationWorker.perform_in(1.second, id)
    end

    def broadcast_new_message
      ActionCable.server.broadcast "customer_chat_support_channel_#{customer_chat_support.id}", chat_datum: as_json, action: 'speak'
    end

    def set_unseen
      if supportable_type == "Customer"
        customer_chat_support.set_seen_at_to_blank
      end
    end
end
