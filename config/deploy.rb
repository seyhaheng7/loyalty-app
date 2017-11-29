lock "3.9.1"

set :application, 'customer-layalty'
set :repo_url, "git@gitlab.com:codingategitlab/app-customer-loyalty.git"

ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :deploy_to, "/var/www/#{fetch(:application)}"

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/uploads')
set :linked_files, fetch(:linked_files, []).push('.env')

set :scm, :git

set :pty, false

set :keep_releases, 3

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

namespace :deploy do

  task :cleanup_assets do
    on roles :all do
      execute "cd #{release_path}/ && ~/.rvm/bin/rvm default do bundle exec rails assets:clobber RAILS_ENV=#{fetch(:stage)}"
    end
  end

  task :swagger_docs do
    on roles :all do
      execute "cd #{release_path}/ && ~/.rvm/bin/rvm default do bundle exec rails swagger:docs RAILS_ENV=#{fetch(:stage)}"
    end
  end

  before :updated, :cleanup_assets
  after :updated, :swagger_docs
end

require "whenever/capistrano"
