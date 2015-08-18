require 'bundler/capistrano'

# set :stages, %w(crevalle)
# set :default_stage, 'crevalle'
# require 'capistrano/ext/multistage'
server '23.92.18.58', :web, :app, :db, primary: true

set :application, 'beatr'
set :repository,  'git@github.com:crevalle/beatr.git'
set :rails_env, 'production'

set :branch, `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(/^refs\/heads\//, '').tap {|branch| puts "\n\tDeploying branch: #{branch}\n\n" } # current branch


default_run_options[:pty] = true # nginx password
set :user, 'desmond'
set :group, 'desmond'
set :use_sudo, false

set :user_home, "/home/#{user}"
set :deploy_to, "#{user_home}/apps/#{application}"

set :shared_config_path, "#{shared_path}/config"

set :ruby_version,  "2.1.2"
set :chruby_exec,   "chruby-exec #{ruby_version}"
set :bundle_cmd,    "#{chruby_exec} -- bundle"
set :whenever_command, "#{chruby_exec} -- whenever"

set :bundle_dir,     ""
set :bundle_flags,   "--system --quiet"
set :bundle_without, [:test, :development]

set :normalize_asset_timestamps, false # don't try to deal with public/images, public/javascripts, etc

desc 'display SHA of last deploy'
task :last_revision do
  version = capture "cat #{current_release}/REVISION"
  puts "\n#{version}"
end

namespace :deploy do
  namespace :assets do
    task :precompile do
    end
  end

  task :start, :roles => :app do
    run "cd #{current_release} && #{bundle_cmd} exec rake websocket_rails:start_server"
  end

  task :stop, :roles => :app do
    run "cd #{current_release} && #{bundle_cmd} exec rake websocket_rails:stop_server"
  end

  task :restart, :roles => :app do
    stop
    start
  end

  task :write_stats do
    run "echo #{branch} > #{shared_path}/system/branch.txt"
  end

  namespace :web do
    task :disable do
      # run "cp #{shared_path}/system/maintenance.html #{shared_path}/tmp/"
    end

    task :enable do
      # run "rm -f #{shared_path}/tmp/maintenance.html"
    end
  end
end

namespace :symlink do
  task :db, roles: :app do
    run "ln -sf #{shared_config_path}/database.yml #{release_path}/config/database.yml"
    run "ln -sf #{shared_config_path}/redis.yml #{release_path}/config/redis.yml"
  end
end

after "deploy:finalize_update", "symlink:db"
after "deploy:update_code", "deploy:write_stats"
after 'deploy:start', 'deploy:web:enable'
before 'deploy:stop', 'deploy:web:disable'

after "deploy:restart", "deploy:cleanup"

