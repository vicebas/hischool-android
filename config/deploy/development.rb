# frozen_string_literal: true

server "54.149.221.190", user: "ubuntu", port: 22, roles: [:web, :app, :db], primary: true
set :nginx_server_name, "devhischool.adaxo.com.br"
set :stage, :development
set :ssh_options, forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/adaxo-dev-key-pair.pem]
