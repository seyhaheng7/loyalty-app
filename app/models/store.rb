class Store < ApplicationRecord
  acts_as_paranoid

  belongs_to :company
  belongs_to :location

  has_many :receipts
  has_many :rewards
  has_many :claimed_rewards, through: :rewards

  validates :name, presence: true, uniqueness: {scope: :company_id}
  validates :address, presence: true

  reverse_geocoded_by :lat, :long

  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }

  def self.order_by(params)
    records = all
    params ||= {}
    if params[:name].present?
      records = records.order(name: params[:name])
    end

    records
  end

  def self.filter(params)

    records = all

    if params[:name].present?
      records = records.name_like(params[:name])
    end

    if params[:lat].present? && params[:long].present?
      records = records.near([params[:lat], params[:long]], 5, units: :km)
    end

    if params[:category_id]
      records = records.joins(:company).merge(Company.in_category(params[:category_id]))
    end

    if params[:only_partners] == 'true'
      records = records.joins(:company).merge(Company.partners)
    end
    records

  end
end
