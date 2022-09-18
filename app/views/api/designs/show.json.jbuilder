json.extract! @design, :id, :title, :description, :nail_part
json.set! :colors do
  json.array! @design.colors, :lame, :hex_number 
end
urls = @design.images.map { |image| rails_blob_url(image) }
json.images urls if @design.images.attached?
