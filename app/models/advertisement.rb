class Advertisement < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true
  validates :banner, presence:true

  mount_uploader :banner, BannerUploader

  def self.filter(params)
    records = all

    if params[:for_page].present?
      records = records.where(for_page: params[:for_page])
    end
    
    records
  end

  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}


end
