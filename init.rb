require 'speedtest'
require 'sinatra/activerecord'
require './models/rate'

test = Speedtest::Test.new(debug: false)

result = test.run
Rate.create({
  download: result.pretty_download_rate,
  upload: result.pretty_upload_rate,
})


