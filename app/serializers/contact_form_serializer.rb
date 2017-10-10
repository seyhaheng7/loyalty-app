class ContactFormSerializer < ActiveModel::Serializer
  attributes :id, :subject, :message
  attributes :errors
  belongs_to :customer
end
