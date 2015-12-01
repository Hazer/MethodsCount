require 'rubygems'
require 'bundler'

env = ENV['RACK_ENV'].to_sym

# Third party deps
Bundler.require

# Logging
::Logger.class_eval { alias :write :'<<' }
if env == :production
  access_log = ::File.new('logs/access.log', 'a+')
  access_log.sync = true
  LOGGER = ::Logger.new(access_log)
  
  ERROR_LOG = ::File.new('logs/error.log', 'a+')
  ERROR_LOG.sync = true
else
  LOGGER = ::Logger.new(STDOUT)
  ERROR_LOG = STDOUT
end

LOGGER.level = (env == :production ? Logger::DEBUG : Logger::DEBUG)

# App deps
require_all 'app'
