set :environment, ENV["RACK_ENV"]
set :output, '/var/log/cron.log'

ENV.each_key do |key|
  env key.to_sym, ENV[key]
end

every 5.minutes do
  rake "rate:save"
end