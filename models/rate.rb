class Rate < ActiveRecord::Base
  def self.get_download
    all.collect { |p| [p.created_at.strftime('%d/%m %H:%M'), p.download] }
  end

  def self.get_upload
    all.collect { |p| [p.created_at.strftime('%d/%m %H:%M'), p.upload] }
  end
end