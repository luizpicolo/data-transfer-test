require 'speedtest'
require 'sinatra/activerecord'

Time.zone = "America/Campo_Grande"
ActiveRecord::Base.default_timezone = :local

class Rate < ActiveRecord::Base
  def self.get_download
    where(created_at: Date.today.all_day).collect { |p| [p.created_at.strftime('%d/%m %H:%M'), p.download] }
  end

  def self.get_upload
    where(created_at: Date.today.all_day).collect { |p| [p.created_at.strftime('%d/%m %H:%M'), p.upload] }
  end

  def self.average_download
    average(:download).ceil(2) 
  end

  def self.average_upload
    average(:upload).ceil(2) 
  end

  def self.save
    test = Speedtest::Test.new(debug: false)
    result = test.run
    
    Rate.create({
      download: result.pretty_download_rate,
      upload: result.pretty_upload_rate,
    })
  end
end