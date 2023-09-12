require 'sinatra/activerecord'

Time.zone = "America/Campo_Grande"
ActiveRecord.default_timezone = :local

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
    results = run_speedtest
    if results
      Rate.create({
        download: results[:download],
        upload: results[:upload],
      })
    end
  end

  def run_speedtest
    output = `speedtest`
    if $?.success?
      download_speed = output.match(/Download:\s+(\d+\.\d+)\sMbps/)[1]
      upload_speed = output.match(/Upload:\s+(\d+\.\d+)\sMbps/)[1]
      {
        download: download_speed.to_f,
        upload: upload_speed.to_f
      }
    else
      nil
    end
  end
end