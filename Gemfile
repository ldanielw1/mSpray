source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

######################################################################
# Rails Framework
######################################################################
gem 'rails', '5.0.3'
gem 'puma', '3.9.1'
gem 'turbolinks', '5.0.1'

group :production do
  gem 'pg' # Must make sure libpq-dev is installed on Ubuntu
end

group :development, :test do
  gem 'sqlite3', '1.3.13'

  gem 'byebug', platform: :mri
  gem 'rspec-rails', '3.5.1'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '3.5.1'
  gem 'listen', '3.0.8'
  gem 'spring', '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

######################################################################
# UI Framework
######################################################################
gem 'bootstrap-sass', '~> 3.2.0'
gem 'font-awesome-sass', '~> 5.0.13'

# Use SCSS for stylesheets
gem 'sass-rails', '5.0.6'

######################################################################
# JS Framework
######################################################################
gem 'coffee-rails', '4.2.2'
gem 'jquery-rails', '4.3.1'
gem 'jbuilder', '2.6.1'

# JS assets compressor
gem 'uglifier', '3.2.0'

# JS runtime
gem 'execjs'
gem 'therubyracer'

# Use Gon gem to make data accessible in JS
gem 'gon'

######################################################################
# Utilities
######################################################################
gem 'omniauth-google-oauth2', '~> 0.2.1'
gem 'google_drive'

group :development, :test do
  gem 'whenever'
end

gem 'fillable-pdf'
