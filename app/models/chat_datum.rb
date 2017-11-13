class ChatDatum < ApplicationRecord
  belongs_to :chat_room
  belongs_to :customer

  has_many :recieved_members, dependent: :destroy

  before_save :set_data_type

  after_commit :broadcast_new_message

  private
    def broadcast_new_message
      json = ChatDatumSerializer.new(self).as_json
      ActionCable.server.broadcast "customer_chat_customer_channel_#{chat_room_id}", chat_datum: json, action: 'speak'
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
