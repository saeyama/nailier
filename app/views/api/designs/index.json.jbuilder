json.set! :designs do
  json.array! @designs do |design|
    json.extract! design, :id, :title
    created_at = design.created_at.strftime('%Y %m %d %H:%M')
    updated_at = design.updated_at.strftime('%Y %m %d %H:%M')
    json.created_at created_at
    json.updated_at updated_at

    image_urls = design.images.map { |image| { 'url': rails_blob_url(image), 'index': rails_blob_url(image).split('/')[8].to_i } }
    sort_image = image_urls.select { |image| image[:index] == 0 }[0][:url]
    json.image sort_image if design.images.attached?
  end
end
