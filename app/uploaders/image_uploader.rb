class ImageUploader < CarrierWave::Uploader::Base

  # storage :file
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'default.png'
  end

  def filename
    @name ||= "#{timestamp}-#{super}" if original_filename.present? and super.present?
  end

  def timestamp
    var = :"@#{mounted_as}_timestamp"
    model.instance_variable_get(var) or model.instance_variable_set(var, Time.now.to_i)
  end

  attr_accessor :geometry

  process :set_geometry


  protected

  def set_geometry
    manipulate! do |image|
      @geometry = ::MiniMagick::Image.open(file.file)[:dimensions]
      image
    end
  end

end
