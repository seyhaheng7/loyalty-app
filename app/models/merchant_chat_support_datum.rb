class MerchantChatSupportDatum < ApplicationRecord
  belongs_to :merchant_chat_support

  belongs_to :supportable, polymorphic: true

  after_commit :show_new_message

  private
    def show_new_message
      MerchantChatSupportWorker.perform_async id
    end

end
