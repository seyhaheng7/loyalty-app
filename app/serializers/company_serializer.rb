class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :point_rate, :logo
  
  has_one :category
  belongs_to :category
end
