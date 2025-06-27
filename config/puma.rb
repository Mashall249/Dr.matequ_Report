max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

worker_timeout 3600 if ENV.fetch("RAILS_ENV", "development") == "development"

environment ENV.fetch("RAILS_ENV") { "development" }

pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

plugin :tmp_restart

rails_root = Dir.pwd
environment Rails.env

bind "unix://#{rails_root}/tmp/sockets/puma.sock"

if Rails.env.production?
  directory rails_root
  pidfile File.join(rails_root, 'tmp', 'pids', 'puma.pid')
  state_path File.join(rails_root, 'tmp', 'pids', 'puma.state')
  stdout_redirect(
    File.join(rails_root, 'log', 'puma.log'),
    File.join(rails_root, 'log', 'puma-error.log'),
    true
  )
  daemonize
end

threads 1, 6
# workers 2 # マルチプロセスが必要なら有効化