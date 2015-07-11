class CreateVideoSources < ActiveRecord::Migration
  def change
    create_table :video_sources do |t|
      t.belongs_to :video, index: true
      t.string :source
    end
  end
end
