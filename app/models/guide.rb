class Guide < ApplicationRecord

  validates :title, presence: true

  mount_uploader :thumbnail, ThumbnailUploader

  default_scope { order(created_at: :desc) }

  scope :title_like, ->(title){ where("#{table_name}.title ilike ?", "%#{title}%") }

  def youtube_id
    YoutubeID.from(youtube_url)
  end

  def embed_url
    url = "http://www.youtube.com/embed/#{youtube_id}"
  end

  # https://www.youtube.com/watch?v=-2U0Ivkn2Ds

end
