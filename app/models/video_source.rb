class VideoSource < ActiveRecord::Base
  belongs_to :video
  mount_uploader :file, VideoUploader

end
