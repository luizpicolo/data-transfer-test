require 'sinatra'
require 'sinatra/activerecord'
require 'chartkick'
require './models/rate'

set :database_file, 'config/database.yml'

Time.now.utc.localtime("-04:00")

get '/' do
  @transfer_rate = [
    {'name': 'Download Rate', 'data': Rate.transfer('download')},
    {'name': 'Upload Rate', 'data': Rate.transfer('upload')}
  ]

  @download_rate = [
    {'name': 'Max Download Rate', 'data': Rate.extremes(:maximum, :download)},
    {'name': 'Min Download Rate', 'data': Rate.extremes(:minimum, :download)},
    {'name': 'Everage Download Rate', 'data': Rate.extremes(:average, :download)}
  ]

  erb :home
end