class VideoAdSerializer < ActiveModel::Serializer
  attributes :id, :title, :video, :start_date, :end_date, :earned_points
end
