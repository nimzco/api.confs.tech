source 'https://rubygems.org'

ruby '3.0.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'administrate', '~> 0.15.0'
gem 'algolia', '~> 2.0.4'
gem 'chronic'
gem 'loofah', '~> 2.3.1'
gem 'pg'
gem 'puma', '~> 5.3.1'
gem 'rails', '~> 6.1.3'
gem 'sidekiq', '~> 4.1.3'
gem 'simple_command'
gem 'twitter', '~> 7.0.0'

gem 'rss', '~> 0.2.9'

gem 'uglifier'
# Ruby toolkit for the GitHub API
gem 'octokit', '~> 4.0'

gem 'devise', '~> 4.7.1'
gem 'watir'

gem 'progress_bar', '~> 1.3.0'

# API
gem 'faraday'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', :require => 'rack/cors'

#
# JWT; Token-based authentication
gem 'jwt'

group :test do
  gem 'mocha', '1.7.0', require: false
  gem 'webmock'
end

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'dotenv-rails', '2.7.6'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop', '~> 0.90'
  gem 'rubocop-performance'
  gem 'rubocop-rails'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
