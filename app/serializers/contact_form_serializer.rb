class ContactFormSerializer < ActiveModel::Serializer
  attributes :id, :subject, :message
  belongs_to :customer
end
