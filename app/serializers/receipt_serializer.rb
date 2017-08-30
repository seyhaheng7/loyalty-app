class ReceiptSerializer < ActiveModel::Serializer
  attributes :id, :receipt_id, :total, :capture, :earned_points, :status
  has_one :store
  has_one :user
end
