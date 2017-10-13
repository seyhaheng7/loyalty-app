class VideoAd < ApplicationRecord
  acts_as_paranoid
  validates :title, presence: true

  mount_uploader :video_file, VideoAdUploader
  mount_uploader :thumbnail, ImageUploader
  
  has_many :view_video_ads, dependent: :destroy

  def youtube_id
    YoutubeID.from(youtube_url)
  end

  def embed_url
    url = "http://www.youtube.com/embed/#{youtube_id}"
  end

  scope :name_like, ->(name){ where("#{table_name}.name ilike ?", "%#{name}%") }


  # order desc & filter by name
  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}

  def self.filter(params)

    records = all

    if params[:title].present?
      records = records.name_like(params[:title])
    end
    records

  end

  def self.order_by(params)
    records = all
    params ||= {}
    if params[:title].present?
      records = records.order(title: params[:title])
    end

    records
  end

end
