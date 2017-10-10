class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :logo
  attributes :errors
  belongs_to :category
end
