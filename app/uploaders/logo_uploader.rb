class LogoUploader < CarrierWave::Uploader::Base

  # storage :file
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    'default.png'
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
