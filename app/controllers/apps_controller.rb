class AppsController < ApplicationController
  require 'fileutils'

  before_action :before_action
  before_action :authenticate_user!, :except => [:show, :index]

  def index
    @apps = App.all
  end

  def list
    @apps = App.all
  end

  def show
    @app = App.find_by_product_id(params[:id])
    @versions = Version.where(app_id: @app.id)
  end

  def new
    @app = App.new

    sql = []
    Version.select('app_id') do |v|
      sql.push(v.app_id)
    end
    @reserved_apps = App.where.not(id: sql)
  end

  def add
    product_id = params[:app][:product_id]
    res = Utils::AppUtil.new("itunes", product_id).save_app
    render :text => "#{product_id}の保存に成功しました！"
  end

  def edit
    @params = params
    @app = App.find_by_product_id(params[:id])
    @version = Version.new
    @version.build_for_sources
    @versions = Version.where(app_id: @app.id)
  end

  def create
    @params = params
    this_version = params[:version][:version]
    app_id = params[:version][:app_id]
    @product_id = App.find(app_id).product_id

    add_version = params[:add_version].nil?
    version = Version.find_by(app_id: app_id, version: this_version)

    if add_version && version
      # 新規追加しようとしてるけど、既にバージョンがあった場合
      @message = "バージョン: #{this_version} は既にあります。"
    elsif add_version && !version
      # 新規追加しようとしてて、バージョンもない場合
      version = Version.new(version_params).save
      if version
        @message = "バージョン: #{this_version} を新規追加し、ビデオを登録しました。"
        App.find(app_id).touch
      else
        @message = "何かがおかしいです！"
      end
    else
      # 既存バージョンへビデオを追加
      videos = version.videos.build(version_params[:videos_attributes][:'0']).save
      if videos
        @message = "バージョン: #{this_version} にビデオを登録しました。"
        App.find(app_id).touch
      else
        @message = "何かがおかしいです！"
      end
    end
  end

  private
    def before_action
      @icon_dir = "/assets/app_icons/"
    end

    def version_params
      params.require(:version).permit(
        :app_id,
        :version,
        videos_attributes: [
          :typeof,
          :title,
          :url,
          video_sources_attributes: [
            :file
          ]
        ]
      )
    end
end
