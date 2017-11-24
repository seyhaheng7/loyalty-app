class ChatMember < ApplicationRecord
  belongs_to :customer
  belongs_to :chat_room

  has_many :recieved_members, dependent: :destroy

  scope :member, ->(member_id){ where(customer_id: member_id) }
end
