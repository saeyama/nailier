json.extract! @design, :id, :title, :description, :nail_part
json.set! :colors do
  json.array! @design.colors, :id, :lame, :hex_number 
end
json.set! :parts do
  json.array! @design.parts, :id, :name, :size, :quantity, :hex_number 
end
json.set! :tags do
  json.array! @design.tags, :id, :name
end
json.set! :youtube_videos do
  json.array! @design.youtube_videos, :id, :access_code
end

image_urls = @design.images.map { |image| { 'id': image.id, 'url': rails_blob_url(image), '_destroy': "0" } }
json.images image_urls if @design.images.attached?

video_urls = @design.videos.map { |video| { 'id': video.id, 'url': rails_blob_url(video), '_destroy': "0"} }
json.videos video_urls if @design.videos.attached?
