$dev_processes	= 1 # dev環境用子プロセス数
$prod_processes	= 4 # 本番環境用子プロセス数
$this_path	= "/usr/lib/rails/directory"	# 環境に合わせて手動で変更

environment = ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'production'

preload_app true

# This configuration file documents many features of Unicorn
# that may not be needed for some applications. See
# http://unicorn.bogomips.org/examples/unicorn.conf.minimal.rb
# for a much simpler configuration file.
#
# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# documentation.

# Use at least one worker per core if you're on a dedicated server,
# more will usually help for _short_ waits on databases/caches.
worker_processes (environment == 'production' ? $prod_processes : $dev_processes)

# Since Unicorn is never exposed to outside clients, it does not need to
# run on the standard HTTP port (80), there is no reason to start Unicorn
# as root unless it's from system init scripts.
# If running the master process as root and the workers as an unprivileged
# user, do this to switch euid/egid in the workers (also chowns logs):
# user "unprivileged_user", "unprivileged_group"

# Help ensure your application will always spawn in the symlinked
# "current" directory that Capistrano sets up.
#working_directory "/path/to/app/current" # available in 0.94.0+

# listen on both a Unix domain socket and a TCP port,
# we use a shorter backlog for quicker failover when busy
listen $this_path + "/tmp/unicorn.sock", :backlog => 64
listen 61000, :tcp_nopush => true

# nuke workers after 30 seconds instead of 60 seconds (the default)
timeout 75 

# feel free to point this anywhere accessible on the filesystem
pid $this_path + "/tmp/unicorn.pid"

stderr_path File.expand_path('../../log/stderr.log', __FILE__)
stdout_path File.expand_path('../../log/stdout.log', __FILE__)

# workerをフォークする前の処理
before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  # The following is only recommended for memory/DB-constrained
  # installations.  It is not needed if your system can house
  # twice as many worker_processes as you have configured.
  #
  # # This allows a new master process to incrementally
  # # phase out the old master process with SIGTTOU to avoid a
  # # thundering herd (especially in the "preload_app false" case)
  # # when doing a transparent upgrade.  The last worker spawned
  # # will then kill off the old master process with a SIGQUIT.
   old_pid = $this_path + "/tmp/unicorn.pid.oldbin"
   if File.exist?(old_pid) && server.pid != old_pid
     begin
     # 古いマスターがいた場合終了させる
     Process.kill("QUIT", File.read(old_pid).to_i)
     rescue Errno::ENOENT, Errno::ESRCH
     # someone else did our job for us
     end
   end
  #
  # Throttle the master from forking too quickly by sleeping.  Due
  # to the implementation of standard Unix signal handlers, this
  # helps (but does not completely) prevent identical, repeated signals
  # from being lost when the receiving process is busy.
  # sleep 1
end

after_fork do |server, worker|
  # per-process listener ports for debugging/admin/migrations
  # addr = "127.0.0.1:#{9293 + worker.nr}"
  # server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => true)

  # the following is *required* for Rails + "preload_app true",
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  # if preload_app is true, then you may also want to check and
  # restart any other shared sockets/descriptors such as Memcached,
  # and Redis.  TokyoCabinet file handles are safe to reuse
  # between any number of forked children (assuming your kernel
  # correctly implements pread()/pwrite() system calls)
end
