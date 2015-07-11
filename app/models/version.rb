class Version < ActiveRecord::Base
  belongs_to :app, touch: true
  has_many :videos
  has_many :video_sources, through: :videos
  accepts_nested_attributes_for :videos

  def build_for_sources
    videos = self.videos.build
    2.times {videos.video_sources.build}
  end
end
