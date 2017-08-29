class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :point_rate, :logo
  belongs_to :category
end
