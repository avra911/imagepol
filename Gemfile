source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.2.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 4.1.20'

gem 'coffee-rails', '~> 5.0'
gem 'turbolinks', '~> 5.2.0'
gem 'jbuilder', '~> 2.9.1'

gem 'mongoid', '7.0.4'
gem 'devise'
gem 'devise-i18n'
gem 'rails_admin'
gem 'kaminari-mongoid'
gem 'omniauth-facebook'
gem "omniauth-rails_csrf_protection", "~> 1.0"
gem 'materialize-sass'
gem 'jquery-rails'
gem "mongoid-paperclip"
gem 'paperclip-gcs'
gem 'dropzonejs-rails'
gem 'mongoid-slug'
gem 'mongoid_rateable'
gem 'translation'
gem 'undraw'
gem 'inline_svg'

gem 'newrelic_rpm'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
