json.extract! @design, :id, :title, :description, :nail_part

colors = @design.colors.map { |color| { 'id': color.id, 'lame': color.lame, 'hexNumber':color.hex_number, '_destroy': '0' } }
json.colors colors

json.set! :parts do
  json.array! @design.parts, :id, :name, :size, :quantity, :hex_number 
end

design_tags = @design.design_tags.map { |design_tag| { id:design_tag.tag[:id] , name:design_tag.tag[:name], design_tag_id: design_tag.id, '_destroy': '0' } }
json.tags design_tags
# json.set! :tags do
#   json.array! @design.tags, :id, :name
# end

youtubeVideos = @design.youtube_videos.map { |youtube_video| { 'id': youtube_video.id, 'accessCode': youtube_video.access_code, '_destroy': '0' } }
json.youtubeVideos youtubeVideos

image_urls = @design.images.map { |image| { 'id': image.id, 'url': rails_blob_url(image), '_destroy': '0' } }
json.images image_urls if @design.images.attached?

video_urls = @design.videos.map { |video| { 'id': video.id, 'url': rails_blob_url(video), '_destroy': '0' } }
json.videos video_urls if @design.videos.attached?
