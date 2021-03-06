class ChatDatum < ApplicationRecord
  TYPES =[
    'text',
    'sticker',
    'audio'
  ]

  belongs_to :chat_room
  belongs_to :customer

  has_many :recieved_members, dependent: :destroy

  before_save :set_data_type

  after_commit :broadcast_new_message
  after_commit :notify_offline_member

  # Create methods (text? sticker? audio?)
  TYPES.each do |chat_type|
    define_method "#{chat_type.downcase.parameterize.underscore}?" do
      data_type == chat_type
    end
  end

  private

    def notify_offline_member
      ChatDataNotificationWorker.perform_in(1.second, id)
    end

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
