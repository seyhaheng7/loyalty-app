class ChatDatum < ApplicationRecord
  belongs_to :chat_room
  belongs_to :customer

  has_many :recieved_members

  after_commit :show_new_message

  before_save :set_data_type

  private
    def show_new_message
      CustomerChatCustomerWorker.perform_async id
    end

    def set_data_type
      if text.present?
        self.data_type = "text"
      else
        self.data_type = "sticker"
      end
    end
end
