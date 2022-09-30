# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

branch = ENV.fetch('SOLIDUS_BRANCH', 'master')

solidus_git, solidus_frontend_git = if (branch == 'master') || (branch >= 'v3.2')
                                      %w[solidusio/solidus solidusio/solidus_frontend]
                                    else
                                      %w[solidusio/solidus] * 2
                                    end

gem 'solidus', github: solidus_git, branch: branch
gem 'solidus_api', github: solidus_git, branch: branch
gem 'solidus_backend', github: solidus_git, branch: branch
gem 'solidus_core', github: solidus_git, branch: branch
gem 'solidus_frontend', github: solidus_frontend_git, branch: branch
gem 'solidus_sample', github: solidus_git, branch: branch

# Needed to help Bundler figure out how to resolve dependencies,
# otherwise it takes forever to resolve them.
# See https://github.com/bundler/bundler/issues/6677
gem 'rails', ENV.fetch('RAILS_VERSION', '>0.a')

# Provides basic authentication functionality for testing parts of your engine
gem 'solidus_auth_devise'

case ENV.fetch('DB', nil)
when 'mysql'
  gem 'mysql2'
when 'postgresql'
  gem 'pg'
else
  gem 'sqlite3'
end

gem 'rails-controller-testing', group: :test

group :development, :test do
  gem 'factory_bot', '> 4.10.0'
  gem 'pry-rails'
end

gemspec

# Use a local Gemfile to include development dependencies that might not be
# relevant for the project or for other contributors, e.g.: `gem 'pry-debug'`.
eval_gemfile 'Gemfile-local' if File.exist? 'Gemfile-local'
