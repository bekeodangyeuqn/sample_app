source "https://rubygems.org"
git_source(:github){|repo| "https://github.com/#{repo}.git"}

ruby "3.0.4"

gem "rails", "~> 6.1.5", ">= 6.1.5.1"

gem "bcrypt", "3.1.13"

gem "rails-i18n"

gem "mysql2"

gem "bootstrap-sass", "3.4.1"

gem "puma", "~> 5.0"

gem "sass-rails", "~> 5.1.0"

gem "webpacker"

gem "turbolinks", "~> 5"

gem "jbuilder", "~> 2.7"

gem "config"

gem "bootsnap", ">= 1.4.4", require: false

gem "faker", "2.1.2"

gem "pagy"

gem "figaro"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rubocop", "~> 1.26", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "rubocop-rails", "~> 2.14.0", require: false
end

group :development do
  gem "listen", "~> 3.3"
  gem "rack-mini-profiler", "~> 2.0"
  gem "spring"
  gem "web-console", ">= 4.1.0"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver", ">= 4.0.0.rc1"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
