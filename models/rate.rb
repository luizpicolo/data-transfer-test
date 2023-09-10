require 'speedtest'
require 'sinatra/activerecord'

Time.zone = "America/Campo_Grande"
ActiveRecord::Base.default_timezone = :local

class Rate < ActiveRecord::Base
  def self.transfer(type_transfer)
    self.find_rate.collect { 
      |p| [p.created_at.strftime('%d/%m %H:%M'), p.public_send(type_transfer)] 
    }
  end

  def self.extremes(type, value)
    hash = self.group("date(created_at)").public_send(type, value)
    hash.transform_keys!{ |k| k.to_date.strftime('%d-%m') }
    hash.transform_values!{ |v| v.ceil(2) }
  end

  def self.find_rate
    where(created_at: Date.today.all_day)
  end

  def self.last_time
    self.transfer('download').last.first
  end

  def self.last_value(type)
    self.transfer(type).last.last
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