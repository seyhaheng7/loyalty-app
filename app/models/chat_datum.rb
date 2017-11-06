class ChatDatum < ApplicationRecord
  belongs_to :chat_room
  belongs_to :customer

  has_many :recieved_members, depentdent: :destroy

  before_save :set_data_type

  after_commit :show_new_message

  private
    def show_new_message
      CustomerChatCustomerWorker.perform_async id
    end

    def set_data_type
      if text.present?
        self.data_type = "text"
      elsif sticker.present?
        self.data_type = "sticker"
      elsif audio.present?
        self.data_type = "audio"
      else
        self.data_type = nil
      end
    end
end
