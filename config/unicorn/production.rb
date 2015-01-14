app_path = '/web/training/trangnth'
working_directory "#{app_path}/current"
pid               "#{app_path}/current/tmp/pids/unicorn.pid"

# listen
listen "/tmp/unicorn.trangnth.venshop.sock"

# logging
stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log"

#workers
worker_processes 1

# user correct Gemfile on restarts
before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/current/Gemfile"
end

# preload
preload_app true

before_fork do |server, worker|

  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before fork, kill the master process that belongs to the .oldbin PID
  # This enables 0 downtime deploys
  old_pid = "#{server.config[:pid]}.oldbin"

  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end
