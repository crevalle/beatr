#!/usr/bin/env puma
#

def production?
  ENV['RAILS_ENV'] == 'production'
end

# Load "path" as a rackup file.
#
# The default is "config.ru".
#
rackup 'cable/config.ru'

# Set the environment in which the rack's app will run. The value must be a string.
# The default is "development".
environment ENV['RAILS_ENV'] || 'development'

# Daemonize the server into the background. Highly suggest that
# this be combined with "pidfile" and "stdout_redirect".
#
# The default is "false".
#
if production?
  daemonize true
  directory '/home/desmond/apps/beatr/current/'

  # Redirect STDOUT and STDERR to files specified. The 3rd parameter
  # ("append") specifies whether the output is appended, the default is
  # "false".
  stdout_redirect 'log/puma.stdout', 'log/puma.stderr', true
end

# Use "path" as the file to store the server info state. This is
# used by "pumactl" to query and control the server.
  pidfile 'tmp/pids/puma.pid'

# Disable request logging.
# The default is "false".
# quiet

# Configure "min" to be the minimum number of threads to use to answer
# requests and "max" the maximum.
#
# The default is "0, 16".
#
# threads 0, 16

# Bind the server to "url". "tcp://", "unix://" and "ssl://" are the only
# accepted protocols.
#
# The default is "tcp://0.0.0.0:9292".
#
  bind 'tcp://0.0.0.0:3013'
  bind 'unix:///var/run/puma.sock'
# bind 'unix:///var/run/puma.sock?umask=0111'
# bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'

# Instead of "bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'" you
# can also use the "ssl_bind" option.
#
# ssl_bind '127.0.0.1', '9292', { key: path_to_key, cert: path_to_cert }

# Code to run before doing a restart. This code should
# close log files, database connections, etc.
#
# This can be called multiple times to add code each time.
#
# on_restart do
#   puts 'On restart...'
# end

# Command to use to restart puma. This should be just how to
# load puma itself (ie. 'ruby -Ilib bin/puma'), not the arguments
# to puma, as those are the same as the original process.
#
# restart_command '/u/app/lolcat/bin/restart_puma'

# === Cluster mode ===

# How many worker processes to run.
#
# The default is "0".
#
# workers 2

# Code to run when a worker boots to setup the process before booting
# the app.
#
# This can be called multiple times to add hooks.
#
# on_worker_boot do
#   puts 'On worker boot...'
# end

# Code to run when a worker boots to setup the process after booting
# the app.
#
# This can be called multiple times to add hooks.
#
# after_worker_boot do
#   puts 'After worker boot...'
# end

# Code to run when a worker shutdown.
#
#
# on_worker_shutdown do
#   puts 'On worker shutdown...'
# end

# Allow workers to reload bundler context when master process is issued
# a USR1 signal. This allows proper reloading of gems while the master
# is preserved across a phased-restart. (incompatible with preload_app)
# (off by default)

# prune_bundler

# Preload the application before starting the workers; this conflicts with
# phased restart feature. (off by default)

# preload_app!

# Additional text to display in process listing
#
# tag 'app name'

# Change the default timeout of workers
#
# worker_timeout 60

# === Puma control rack application ===

# Start the puma control rack application on "url". This application can
# be communicated with to control the main server. Additionally, you can
# provide an authentication token, so all requests to the control server
# will need to include that token as a query parameter. This allows for
# simple authentication.
#
# Check out https://github.com/puma/puma/blob/master/lib/puma/app/status.rb
# to see what the app has available.
#
# activate_control_app 'unix:///var/run/pumactl.sock'
# activate_control_app 'unix:///var/run/pumactl.sock', { auth_token: '12345' }
# activate_control_app 'unix:///var/run/pumactl.sock', { no_token: true }
