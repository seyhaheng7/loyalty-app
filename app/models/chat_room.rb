class ChatRoom < ApplicationRecord
  has_many :chat_members
  has_many :customers, through: :chat_members
  has_many :chat_data

  scope :member, ->(member_id){ joins(:chat_members).merge(ChatMember.member(member_id)) }


  def self.members(member1_id, member2_id)
    chat_room_ids = ChatRoom.member(member1_id).ids
    where(id: chat_room_ids).member(member2_id)
  end
end
