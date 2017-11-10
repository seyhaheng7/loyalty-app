class VideoAd < ApplicationRecord
  validates :title, presence: true
  validates :video_file, presence: true
  validates :thumbnail, presence: true

  mount_uploader :video_file, VideoAdUploader
  mount_uploader :thumbnail, ImageUploader
  mount_uploader :banner, ImageUploader

  has_many :view_video_ads, dependent: :destroy

  def youtube_id
    YoutubeID.from(youtube_url)
  end

  def embed_url
    url = "http://www.youtube.com/embed/#{youtube_id}"
  end

  scope :title_like, ->(title){ where("#{table_name}.title ilike ?", "%#{title}%") }


  # order desc & filter by name
  scope :active, -> {where(":today >= start_date AND :today <= end_date", today: Date.today)}

  scope :start_between, ->(start_date, end_date){ where(start_date: start_date.beginning_of_day..end_date.end_of_day) }
  scope :end_between, ->(start_date, end_date){ where(end_date: start_date.beginning_of_day..end_date.end_of_day) }
  scope :active_between, ->(start_date, end_date){ start_between(start_date, end_date).or(end_between(start_date, end_date)) }

  def self.filter(params)

    records = all

    if params[:title].present?
      records = records.title_like(params[:title])
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
