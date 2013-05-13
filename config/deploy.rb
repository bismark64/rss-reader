require "bundler/capistrano"
require "whenever/capistrano"
require 'capistrano_recipes'

set :application, "Rss Reader"
set :repository,  "git@github.com:bismark64/rss-reader.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :branch, "master"
set :use_sudo, false
set :deploy_via, :remote_cache

set :deploy_to, "/var/www/#{application}"

role :web, "deployserver.com"                          # Your HTTP server, Apache/etc
role :app, "deployserver.com"                          # This may be the same as your `Web` server
role :db,  "deployserver.com", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# We will use Unicorn as our webserver
set :server, :unicorn

# Whenever 
set :whenever_command, "bundle exec whenever"

#Sunspot
namespace :deploy do
  task :setup_solr_data_dir do
    run "mkdir -p #{shared_path}/solr/data"
  end
end

namespace :solr do
  desc "start solr"
  task :start, :roles => :app, :except => { :no_release => true } do 
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec sunspot-solr start --port=8983 --data-directory=#{shared_path}/solr/data --pid-dir=#{shared_path}/pids"
  end
  desc "stop solr"
  task :stop, :roles => :app, :except => { :no_release => true } do 
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec sunspot-solr stop --port=8983 --data-directory=#{shared_path}/solr/data --pid-dir=#{shared_path}/pids"
  end
  desc "reindex the whole database"
  task :reindex, :roles => :app do
    stop
    run "rm -rf #{shared_path}/solr/data"
    start
    run "cd #{current_path} && RAILS_ENV=#{rails_env} bundle exec rake sunspot:solr:reindex"
  end
end

before :deploy, 'solr:stop'
after 'deploy:setup', 'deploy:setup_solr_data_dir'
after :deploy, 'solr:start'
