# encoding: utf-8

source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '4.0.5'
gem 'sqlite3'
gem 'sass-rails'
gem 'uglifier', '2.1.1'
gem 'coffee-rails', '4.0.1'
gem 'jquery-rails', '3.0.4'
gem 'turbolinks', '1.1.1'
gem 'jbuilder', '1.0.2'
gem 'haml-rails'
gem 'bourbon'
gem 'neat'
gem 'devise'

# Install dependances of 'rmagick' before you 'bundle install' at your first time
# sudo yum -y install ImageMagick
# sudo yum -y install ImageMagick-devel
gem 'rmagick'

gem 'carrierwave'
gem 'carrierwave-video-thumbnailer'

gem 'streamio-ffmpeg'

group :development, :test do
  # 参考: http://ruby-rails.hatenadiary.com/entry/20150108/1420721205
  gem 'pry-rails'  # rails console(もしくは、rails c)でirbの代わりにpryを使われる
  gem 'pry-doc'    # methodを表示
  gem 'pry-byebug' # デバッグを実施(Ruby 2.0以降で動作する)
  gem 'pry-stack_explorer' # スタックをたどれる
end

group :doc do
  gem 'sdoc', '0.3.20', require: false
end
