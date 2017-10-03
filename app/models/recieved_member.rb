class RecievedMember < ApplicationRecord
  belongs_to :chat_datum
  belongs_to :chat_member
end
