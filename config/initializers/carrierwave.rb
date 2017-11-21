CarrierWave.configure do |config|
  config.storage = :file
  config.asset_host = ActionController::Base.asset_host
  if ENV['ENABLE_S3'] == 'true'
    if Rails.env.staging? || Rails.env.production?
      config.fog_provider = 'fog/aws'
      config.fog_credentials = {
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        provider: 'AWS',
        region: ENV['FOG_REGION']
      }
      config.storage = :fog
      config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
      config.fog_directory = ENV['FOG_DIRECTORY']
    end
  end
end

