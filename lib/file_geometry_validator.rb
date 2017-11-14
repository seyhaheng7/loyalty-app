class FileGeometryValidator < ActiveModel::EachValidator

  MESSAGES = {is: :wrong_geometry, minimum: :geometry_too_small, maximum: :geometry_too_big}
  CHECKS = {is: :==, minimum: :>=, maximum: :<=}

  def validate_each(record, attribute, value)
    raise(ArgumentError, 'A CarrierWave::Uploader::Base object was expected') unless value.kind_of? CarrierWave::Uploader::Base
    options.each do |k, v|
      next unless CHECKS.keys.include?(k) && value.geometry.present?
      raise(ArgumentError, 'An Array object with two Integer was expected') unless v.kind_of?(Array) && v.size == 2
      unless value.geometry.first.send(CHECKS[k], v.first) || value.geometry.last.send(CHECKS[k], v.last)
        record.errors.add(attribute, MESSAGES[k], file_geometry: options[k].join('x'))
      end
    end
  end

end