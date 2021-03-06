class Store < ApplicationRecord
  acts_as_paranoid

  belongs_to :company, optional: true
  belongs_to :location, optional: true

  has_many :receipts, dependent: :destroy
  has_many :rewards, dependent: :destroy
  has_many :claimed_rewards, through: :rewards
  has_many :merchants, dependent: :destroy

  has_many :store_banners, dependent: :destroy
  accepts_nested_attributes_for :store_banners, allow_destroy: true,  reject_if: :all_blank


  validates :name, presence: true, uniqueness: {scope: :company_id}
  validates :address, presence: true
  validates :term_and_condition, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }, allow_blank: true

  reverse_geocoded_by :lat, :long

  default_scope { order(completed: :desc, created_at: :desc) }

  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }
  scope :in_category, ->(category_id){ joins(:company).merge(Company.in_category(category_id)) }

  delegate :name, to: :company, prefix: true, allow_nil: true
  delegate :name, to: :location, prefix: true, allow_nil: true

  def self.order_by(params)
    records = all
    params ||= {}
    if params[:name].present?
      records = records.reorder(name: params[:name])
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
