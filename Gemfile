source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

######################################################################
# Rails Framework
######################################################################
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'puma', '~> 5.0'
gem 'turbolinks', '~> 5'

group :production do
  gem 'pg' # Must make sure libpq-dev is installed on Ubuntu
end

group :development, :test do
  gem 'sqlite3', '~> 1.4'

  gem 'byebug', platform: :mri
  gem 'rspec-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

######################################################################
# UI Framework
######################################################################
gem 'materialize-sass'
gem 'font-awesome-sass', '~> 5.0.13'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

######################################################################
# JS Framework
######################################################################
gem 'coffee-rails'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.7'

# JS assets compressor
gem 'uglifier', '~> 3.2'

# JS runtime
gem 'execjs'
gem 'mini_racer', '~> 0.3'

# Use Gon gem to make data accessible in JS
gem 'gon'

######################################################################
# Utilities
######################################################################
gem 'google_sign_in'
gem 'google_drive'

group :development, :test do
  gem 'whenever'
end

gem 'fillable-pdf'
