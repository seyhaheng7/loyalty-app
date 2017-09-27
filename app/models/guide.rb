class Guide < ApplicationRecord
  acts_as_paranoid

  validates :title, presence: true
  
  def youtube_id
    YoutubeID.from(youtube_url)
  end

  def embed_url
    url = "http://www.youtube.com/embed/#{youtube_id}"
  end

  # https://www.youtube.com/watch?v=-2U0Ivkn2Ds

end
