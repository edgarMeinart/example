# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.4.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2'
gem "sprockets", "~> 3.7.2"

# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'

gem 'active_model_serializers', '~> 0.10.0'

# A Ruby framework for rapid API development with great conventions
gem 'grape', '~> 1.3'
gem 'grape-active_model_serializers', '~> 1.5'

gem 'acts-as-taggable-on', '~> 6.0'

gem 'money-rails', '~> 1.13'

group :development, :test do
  gem 'pry', '~> 0.13.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem "diff-lcs"
  gem 'rspec-rails', '~> 3.4'
end
