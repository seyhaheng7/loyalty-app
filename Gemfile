source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'

gem 'rails',              '~> 5.1.2'
gem 'pg',                 '~> 0.18'
gem 'puma',               '~> 3.7'
gem 'sass-rails',         '~> 5.0'
gem 'uglifier',           '>= 1.3.0'
gem 'coffee-rails',       '~> 4.2'

gem 'jquery-rails',       '~> 4.3.1'
gem 'simple_form',        '3.5.0'
gem 'bootstrap-sass',     '~> 3.3.6'
gem 'carrierwave',        '~> 1.1.0'
gem 'devise',             '~> 4.3.0'
gem 'devise_token_auth',  '~> 0.1.42'
gem 'omniauth',           '~> 1.6.1'
gem 'font-awesome-rails', '~> 4.7.0.2'
gem 'devise_security_extension', git: "https://github.com/phatworx/devise_security_extension.git", ref: 'b2ee978af7d49f0fb0e7271c6ac074dfb4d39353' # TO DO: use version after next release
# gem 'rails_email_validator'
gem 'haml-rails',         '~> 0.9'
gem 'swagger-docs'
gem 'rubocop',            '~> 0.49.1'
gem 'brakeman',           '>= 3.7.2'
gem 'datagrid',           '~> 1.5'
gem 'nexmo',              '~> 4.7.0'
gem 'sidekiq',            '~> 5.0.4'
gem 'ffaker',             '~> 2.6.0'
gem 'bullet',             '~> 5.6.1'

group :development, :test do
  gem 'lunchy'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.15'
  gem 'selenium-webdriver'
  gem 'pry'
  gem 'rspec-rails',        '~> 3.5'
  gem 'database_cleaner',   '~> 1.6.1'
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'shoulda-matchers',   '~> 3.1'
  gem 'capistrano-rails',   '~> 1.1.1'
  gem 'capistrano-passenger'
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'
  gem 'pry-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener', '~> 1.4.1'
end


gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "pundit", '~> 1.1.0'
gem 'active_model_serializers', '~> 0.10.6'
gem 'dotenv-rails', '~> 2.2.1'
gem 'rack-cors', :require => 'rack/cors'
gem 'kaminari'
gem "paranoia", "~> 2.2"
gem 'carrierwave-base64', "~> 2.3.5"
gem 'aasm', '~> 4.12.2'
gem 'geocoder', "~> 1.4.4"
gem 'draper', "~> 3.0.0"
gem 'rails-settings-cached', '~> 0.6.6'
gem "select2-rails", "~> 4.0.3"

gem 'omniauth-facebook', '~> 1.4.0'
gem 'omniauth-google-oauth2'
gem 'ckeditor', '~> 4.2'
gem 'youtube_id', '~> 0.0.3'
gem 'whenever', '~> 0.9.7'

gem "asset_sync", '~> 2.2.0'
gem "fog-aws", '~> 1.4.1'
gem 'jquery-ui-rails'