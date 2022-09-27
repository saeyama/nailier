class ChangeVideosToYoutubeVideos < ActiveRecord::Migration[6.1]
  def change
    rename_table :videos, :youtube_videos
  end
end
