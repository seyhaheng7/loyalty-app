class GuideSerializer < ActiveModel::Serializer
  attributes :id, :title, :youtube_url, :embed_url
  attributes :errors
end
