class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :logo
  belongs_to :category
end
