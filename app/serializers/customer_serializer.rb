class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :avatar, :email, :phone, :gender, :address, :current_points, :lat, :long, :is_completed_profile

  def is_completed_profile
    object.completed_profile?
  end

end
