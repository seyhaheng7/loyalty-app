class OperatingSystemSerializer < ActiveModel::Serializer
  attributes :id, :name, :errors
  belongs_to :user
end
