class CustomerChatSupportDatum < ApplicationRecord
  belongs_to :customer_chat_support
  belongs_to :supportable, polymorphic: true

  after_commit :show_new_message
  after_commit :set_unseen

  private
    def show_new_message
      CustomerChatSupportWorker.perform_async id
    end

    def set_unseen
      if supportable_type == "Customer"
        customer_chat_support.set_seen_at_to_blank
      end
    end
end
