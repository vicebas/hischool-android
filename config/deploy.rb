# frozen_string_literal: true

lock "~> 3.11.0"
set :repo_url, "git@bitbucket.org:TEAMADAXO/hs-back-end.git"
set :application, "hischool"
set :user, "ubuntu"
set :puma_threads, [4, 16]
set :puma_workers, 0

# Don't change these unless you know what you're doing
set :pty, true
set :use_sudo, false
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord
set :rbenv_ruby, "2.6.1"

## Defaults:
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :log_level,   :debug
set :keep_releases, 5

# Postgresql setup
set :pg_without_sudo, false
set :pg_host, "localhost"
set :pg_ask_for_password, true
set :pg_username, "postgres"
set :pg_password, "postgres"
set :pg_extensions, ["citext", "hstore", "pgcrypto"]
set :pg_encoding, "UTF-8"
set :pg_pool, "50"

## Linked Files & Directories (Default None):
set :linked_files, %w{config/database.yml config/secrets.yml }
set :linked_dirs,  %w{tmp/pids tmp/sockets public/system public/assets log}

namespace :puma do
  desc "Create Directories for Puma Pids and Socket"
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Initial Deploy"

  task :initial do
    on roles(:app) do
      before "deploy:restart", "puma:start"
      invoke "deploy"
    end
  end

  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke!("puma:restart")
    end
  end

  after :finishing,  :compile_assets
  after :finishing,  :cleanup
  after :finishing,  :restart
end
