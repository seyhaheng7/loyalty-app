AssetSync.configure do |config|
  config.enabled = (ENV['ENABLE_S3'] == 'true')
  config.fog_provider = 'AWS'
  config.fog_directory = ENV['FOG_DIRECTORY']
  config.aws_access_key_id = ENV['AWS_ACCESS_KEY_ID']
  config.aws_secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']


  config.existing_remote_files = 'delete'

  config.fog_region = ENV['FOG_REGION']
  config.gzip_compression = true
  config.custom_headers = { '.*' => { cache_control: 'max-age=315576000', expires: 1.year.from_now.httpdate } }
end
