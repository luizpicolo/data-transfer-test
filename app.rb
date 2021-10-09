require 'sinatra'
require 'sinatra/activerecord'
require 'chartkick'
require './models/rate'

set :database_file, 'config/database.yml'

Time.now.utc.localtime("-04:00")

get '/' do
  @down_everage = Rate.average(:download)
  @up_everage = Rate.average(:upload)
  
  @max_download = Rate.extremes(:maximum, :download)
  @min_download = Rate.extremes(:minimum, :download)
  @max_upload = Rate.extremes(:maximum, :upload)
  @min_upload = Rate.extremes(:minimum, :upload)
  
  @data = [
    { 
      'name': 'Download Rate', 
      'data': Rate.transfer('download')
    },
    { 
      'name': 'Upload Rate', 
      'data': Rate.transfer('upload')
    },
  ]

  erb :home
end