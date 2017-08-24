source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

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
gem 'haml-rails',         '~> 0.9'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'pry'
  gem 'rspec-rails',        '~> 3.5'
  gem 'ffaker',             '~> 2.6.0'
  gem 'database_cleaner',   '~> 1.6.1'
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end


gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "pundit", '~> 1.1.0'