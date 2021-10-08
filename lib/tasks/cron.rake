namespace :rate do
  desc "create and save rate"
  task :save do
    Rate.save
  end
end