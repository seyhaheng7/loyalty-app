class GuideSerializer < ActiveModel::Serializer
  attributes :id, :title, :youtube_url, :embed_url, :thumbnail
  attributes :errors
end
