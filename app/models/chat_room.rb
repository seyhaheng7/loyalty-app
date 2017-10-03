class ChatRoom < ApplicationRecord
  has_many :chat_members
  has_many :customers, through: :chat_members
  has_many :chat_data

  scope :member, ->(member_id){ joins(:chat_members).merge(ChatMember.member(member_id)) }
end
