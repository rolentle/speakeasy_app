path = File.expand_path(File.dirname(__FILE__))

BASE_URL = 'http://localhost:9000/'

AUTH_SERVER_PORT = 5000
FRONTEND_SERVER_PORT = 5002
CORE_SERVER_PORT = 5003
GITHUB_PORT = 5004
SEARCH_PORT = 5005
DASHBOARD_PORT = 5006

RAILS_ENV = 'development'

# System files

# God.watch do |w|
#   w.name = "redis"
#   w.start = "redis-server"
#   w.keepalive
# end

# Our Processes

God.watch do |w|
  w.name = "authentication server"
  w.start = "cd #{path}/speakeasy_bouncer/; RAILS_ENV=#{RAILS_ENV} BASE_URL=#{BASE_URL} bundle exec thin start -p #{AUTH_SERVER_PORT}"
  w.keepalive
end

God.watch do |w|
 w.name = "faye"
 w.start = "cd #{path}/speakeasy_dumbwaiter/; ruby faye.rb"
 w.keepalive
end

God.watch do |w|
  w.name = "frontend server"
  w.start = "cd #{path}/speakeasy_vaudeville/; RAILS_ENV=#{RAILS_ENV} BASE_URL=#{BASE_URL} bundle exec thin start -p #{FRONTEND_SERVER_PORT}"
  w.keepalive
end

God.watch do |w|
  w.name = "core server"
  w.start = "cd #{path}/speakeasy_core/; RAILS_ENV=#{RAILS_ENV} BASE_URL=#{BASE_URL} bundle exec thin start -p #{CORE_SERVER_PORT}"
  w.keepalive
end

God.watch do |w|
  w.name = "github server"
  w.start = "cd #{path}/speakeasy_github/; RAILS_ENV=#{RAILS_ENV} BASE_URL=#{BASE_URL} bundle exec thin start -p #{GITHUB_PORT}"
  w.keepalive
end

God.watch do |w|
  w.name = "search server"
  w.start = "cd #{path}/speakeasy_gumshoe/; RAILS_ENV=#{RAILS_ENV} BASE_URL=#{BASE_URL} bundle exec thin start -p #{SEARCH_PORT}"
  w.keepalive
end

God.watch do |w|
  w.name = "cheque (dashboard) server"
  w.start = "cd #{path}/speakeasy_cheque/; RAILS_ENV=#{RAILS_ENV} BASE_URL=#{BASE_URL} bundle exec thin start -p #{DASHBOARD_PORT}"
  w.keepalive
end

God.watch do |w|
  w.name = "search redis server"
  w.start = "cd #{path}/speakeasy_cheque/; rake subscribe"
  w.keepalive
end

God.watch do |w|
  w.name = "search redis server"
  w.start = "cd #{path}/speakeasy_gumshoe/; rake subscribe"
  w.keepalive
end

God.watch do |w|
  w.name = "search indexer"
  w.start = "cd #{path}/speakeasy_gumshoe/; rake index"
  w.keepalive
end

God.watch do |w|
  w.name = "logger redis server"
  w.start = "cd #{path}/speakeasy_cheque/; rake subscribe"
  w.keepalive
end

# God.watch do |w|
#   w.name = "logger mongo db"
#   w.start = "mongod"
#   w.keepalive
# end
