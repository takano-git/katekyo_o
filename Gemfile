source 'https://rubygems.org'

gem 'rails',        '~> 5.1.6'
gem 'bootstrap-sass'
gem 'rails-i18n'
gem 'bcrypt'
gem 'faker'
gem 'bootstrap-sass'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'puma',         '~> 3.7'
gem 'sass-rails',   '~> 5.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks',   '~> 5'
gem 'jbuilder',     '~> 2.5'
# カレンダー機能の為、以下２つ追加。jqueryはバージョン指定していないものを
# 以前追加していたので省略
# gem 'jquery-rails', '4.3.3'
# gem 'fullcalendar-rails'
gem 'momentjs-rails'
# 以下２つがLINE bot 機能実装の為、入れたgem
gem 'line-bot-api'
gem 'dotenv-rails'       #環境変数を管理するgem
# gem 'rack-cors'
# gem 'devise'
# gem 'devise_token_auth'
# gem 'omniauth'
# gem 'omniauth-line'

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg', '0.20.0'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
# Mac環境でもこのままでOKです
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]