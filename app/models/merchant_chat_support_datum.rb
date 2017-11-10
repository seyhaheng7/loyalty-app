class MerchantChatSupportDatum < ApplicationRecord
  belongs_to :merchant_chat_support
  belongs_to :supportable, polymorphic: true

  after_commit :show_new_message
  after_commit :set_unseen

  private
    def show_new_message
      ActionCable.server.broadcast "merchant_chat_support_channel_#{merchant_chat_support.id}", chat_datum: as_json, action: 'speak'
    end

    def set_unseen
      if supportable_type == "Merchant"
        merchant_chat_support.set_seen_at_to_blank
      end
    end

end
