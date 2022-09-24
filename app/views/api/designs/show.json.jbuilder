json.extract! @design, :id, :title, :description, :nail_part
json.set! :colors do
  json.array! @design.colors, :id, :lame, :hex_number 
end
json.set! :parts do
  json.array! @design.parts, :id, :name, :size, :quantity, :hex_number 
end

image_urls = @design.images.map { |image| rails_blob_url(image) }
json.images image_urls if @design.images.attached?

video_urls = @design.videos.map { |video| rails_blob_url(video) }
json.videos video_urls if @design.videos.attached?
