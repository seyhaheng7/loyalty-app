class VideoAdSerializer < ActiveModel::Serializer
  attributes :id, :title, :video_file, :start_date, :end_date, :earned_points
end
