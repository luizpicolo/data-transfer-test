# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'activerecord'
gem 'speedtest'
gem 'sinatra'
gem 'sinatra-activerecord'
gem 'chartkick'
gem 'sqlite3'
gem 'rake'
gem 'whenever', require: false

group :development do
  gem 'rerun'
end

group :production do
  gem 'puma'
end
