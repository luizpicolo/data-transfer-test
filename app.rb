require 'sinatra'
require 'sinatra/activerecord'
require 'chartkick'
require './models/rate'

set :database_file, 'config/database.yml'

Time.now.utc.localtime("-04:00")

get '/' do
  @data = [
    { 
      'name': 'Taxa de Download', 
      'data': Rate.get_download
    },
    { 
      'name': 'Taxa de Upload', 
      'data': Rate.get_upload
    },
  ]

  erb :home
end