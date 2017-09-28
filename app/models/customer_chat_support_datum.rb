class CustomerChatSupportDatum < ApplicationRecord
  belongs_to :customer_chat_support
  belongs_to :supportable, polymorphic: true

  after_commit :show_new_message

  private
    def show_new_message
      CustomerChatSupportWorker.perform_async id
    end
end
