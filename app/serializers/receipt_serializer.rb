class ReceiptSerializer < ActiveModel::Serializer
  attributes :id, :receipt_id, :total, :capture, :earned_points, :status, :errors
  belongs_to :store
  belongs_to :customer
end
