json.extract! @design, :id, :title, :description, :nail_part

colors = @design.colors.map { |color| { 'id': color.id, 'lame': color.lame, 'hexNumber': color.hex_number, '_destroy': '0' } }
json.colors colors

parts = @design.parts.map { |part| { 'id': part.id, 'name': part.name, 'size': part.size, 'quantity': part.quantity, 'hexNumber': part.hex_number, '_destroy': '0' } }
json.parts parts

design_tags = @design.design_tags.map { |design_tag| { id:design_tag.tag[:id] , name:design_tag.tag[:name], design_tag_id: design_tag.id, '_destroy': '0' } }
json.tags design_tags

youtubeVideos = @design.youtube_videos.map { |youtube_video| { 'id': youtube_video.id, 'accessCode': youtube_video.access_code, '_destroy': '0' } }
json.youtubeVideos youtubeVideos

image_urls = @design.images.map { |image| { 'id': image.id, 'url': rails_blob_url(image), '_destroy': '0', 'index': rails_blob_url(image).split('/')[8].to_i } }
sort_images = image_urls.sort {|x, y| x[:index] <=> y[:index] } if @design.images.attached?
json.images sort_images

video_urls = @design.videos.map { |video| { 'id': video.id, 'url': rails_blob_url(video), '_destroy': '0' } }
json.videos video_urls if @design.videos.attached?
