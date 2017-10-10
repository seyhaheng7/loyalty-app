class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email
  attributes :errors
  has_many :operating_systems
end
