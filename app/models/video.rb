class Video < ActiveRecord::Base
  belongs_to :version
  has_many :video_sources
  accepts_nested_attributes_for :video_sources

end
