# encoding: utf-8

class VideoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  include CarrierWave::Video::Thumbnailer
  require 'streamio-ffmpeg'

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "#{Rails.root}/public/videos/#{@product_id}/#{@version}"
  end

  def cache_dir
    "#{Rails.root}/tmp/cache/"
  end

  #
  # ----------------------------------------
  # サムネイラに必要なffmpegをインストールする
  # http://qiita.com/RyoIkarashi/items/48419f71f15f97c46123
  # ----------------------------------------
  #
  # ----------------------------------------
  # 参考: Ruby on Rails で動画をアップロード – CarrierWaveとFFmpeg
  # http://dev.classmethod.jp/server-side/ruby-on-rails/ruby-on-rails-carrierwave-ffmpeg/
  # ----------------------------------------
  # Create different versions of your uploaded files:
  version :thumbnail, :if => :is_mp4? do
    process :thumbnail
  end

  def thumbnail
    movie = FFMPEG::Movie.new(current_path)
    movie.screenshot("ss.png", { seek_time: 0, resolution: '242x428' }, preserve_aspect_ratio: :width)
    File.delete(current_path)
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(mp4 webm)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    video = Video.find(model.video_id)
    version_id = video.version_id
    @version = Version.find(version_id).version
    app_id = Version.find(version_id).app_id
    @product_id = App.find(app_id).product_id

    # rootにあるスクリーンショットファイルをリネーム
    if file.content_type = "video/mp4" && File.exist?("#{Rails.root}/ss.png") then
      FileUtils.mkdir_p("#{store_dir}") unless Dir.exist?("#{store_dir}")
      File.rename("#{Rails.root}/ss.png", "#{store_dir}/thumb_#{model.video_id}.png")
    end

    ex = original_filename[/\.\w+$/]
    "#{model.video_id}#{ex}"
  end

  protected
    def is_mp4?(new_file)
      is = original_filename[/\.\w+$/].include?("mp4")
    end
end
