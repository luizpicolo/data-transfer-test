require 'sinatra'
require 'sinatra/activerecord'
require 'chartkick'
require './models/rate'

set :database_file, 'config/database.yml'

Time.now.utc.localtime("-04:00")

get '/' do
  @data = [
    { 
      'name': 'Download Rate', 
      'data': Rate.get_download
    },
    { 
      'name': 'Upload Rate', 
      'data': Rate.get_upload
    },
  ]

  erb :home
end