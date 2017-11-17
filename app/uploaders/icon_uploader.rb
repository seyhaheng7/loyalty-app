class IconUploader < CarrierWave::Uploader::Base

  # storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'default.png'
  end

  def filename
    @name ||= "#{super}-#{Devise.friendly_token}" if original_filename.present? and super.present?
  end

end
