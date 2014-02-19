# ワーカーの数
worker_processes 2

# capistrano 用に RAILS_ROOT を指定
working_directory "/home/r-sakon/project/spree_store"

# ソケット
listen File.expand_path('tmp/sockets/unicorn.sock', ENV['RAILS_ROOT'])
pid File.expand_path('tmp/pids/unicorn.pid', ENV['RAILS_ROOT'])

# ログ
log = File.expand_path('log/unicorn.log', ENV['RAILS_ROOT'])
stderr_path File.expand_path('log/unicorn_stderr.log', ENV['RAILS_ROOT'])
stdout_path File.expand_path('log/unicorn_stdout.log', ENV['RAILS_ROOT'])

# ダウンタイムなくす
preload_app true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!

  old_pid = "#{ server.config[:pid] }.oldbin"
  unless old_pid == server.pid
    begin
      Process.kill :QUIT, File.read(old_pid).to_i
      rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end