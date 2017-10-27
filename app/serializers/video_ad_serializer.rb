class VideoAdSerializer < ActiveModel::Serializer
  attributes :id, :title, :video_file, :start_date, :end_date, :earned_points, :thumbnail, :label, :ios_url, :android_url, :banner
  attributes :errors
end
