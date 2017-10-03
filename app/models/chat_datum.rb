class ChatDatum < ApplicationRecord
  belongs_to :chat_room
  belongs_to :customer

  has_many :recieved_members

  after_commit :show_new_message

  private
    def show_new_message
      CustomerChatCustomerWorker.perform_async id
    end
end
