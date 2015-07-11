# coding: utf-8

class Utils::AppUtil
  require 'open-uri'
  require 'FileUtils'
  require 'rmagick'

  def initialize(platform, id)
    @platform, @id = platform, id
  end
  
  def itunes
    app_url  = "https://itunes.apple.com/lookup?id=#{@id}&country=jp"
    app_res  = open(app_url)
    response = ActiveSupport::JSON.decode app_res.read

    @results = response["results"][0]
    return @results
  end

  def save_app
    unless @id.empty? then

      app = self.results
      
      name      = results["trackName"]
      genre     = results["genres"].to_s
      version   = results["version"]
      developer = results["artistName"]
      url       = results["trackViewUrl"]

      # アイコンを取得してリサイズ、それを保存して "画像名.拡張子" を返す
      icon_filename = self.save_icon

      App.create(
        :product_id      => @id,
        :name            => name,
        :genre           => genre,
        :current_version => version,
        :icon_filename   => icon_filename,
        :developer       => developer,
        :url             => url
      )
    end
  end

  def results
    case @platform
    when "itunes"
     return self.itunes
    else
     return nil
    end
  end

  def save_icon
    # アイコンを取得してリサイズ
    width, height = 500, 500
    icon_url  = @results["artworkUrl512"]
    icon_blob = open(icon_url).read
    image     = Magick::Image.from_blob(icon_blob).shift
    icon      = image.resize_to_fill!(width, height).to_blob

    # アイコンの保存
    extname      = File.extname(icon_url)
    file_name    = @id.to_s + extname
    app_icon_dir = "app/assets/images/app_icons/"
    file_dir     = Rails.root.to_s + "/" + app_icon_dir

    # ディレクトリがなかったら作る
    unless FileTest.exist?(file_dir) then
      puts "mkdir: #{file_dir}"
      FileUtils.mkdir_p(file_dir)
    end

    file_path = file_dir + file_name
    dest      = open(file_path, "wb")
    dest.write(icon)
    puts "#{file_name} saved to [#{file_dir}]"

    return file_name
  end
end
