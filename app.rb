require 'sinatra'
require 'sinatra/activerecord'
require 'chartkick'
require './models/rate'

set :database_file, 'config/database.yml'

Time.now.utc.localtime("-04:00")

get '/' do
  @transfer_rate = [
    {'name': 'Download', 'data': Rate.transfer('download')},
    {'name': 'Upload', 'data': Rate.transfer('upload')}
  ]

  @download_rate = [
    {'name': 'Max', 'data': Rate.extremes(:maximum, :download)},
    {'name': 'Min', 'data': Rate.extremes(:minimum, :download)},
    {'name': 'Everage', 'data': Rate.extremes(:average, :download)}
  ]

  @upload_rate = [
    {'name': 'Max', 'data': Rate.extremes(:maximum, :upload)},
    {'name': 'Min', 'data': Rate.extremes(:minimum, :upload)},
    {'name': 'Everage', 'data': Rate.extremes(:average, :upload)}
  ]

  erb :home
end