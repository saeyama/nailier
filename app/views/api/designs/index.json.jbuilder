json.set! :designs do
  json.array! @designs do |design|
    json.extract! design, :id, :title, :nail_part
    human_created_at = design.created_at.strftime('%Y %m %d %H:%M')
    human_updated_at = design.updated_at.strftime('%Y %m %d %H:%M')
    json.human_created_at human_created_at
    json.human_updated_at human_updated_at

    tags = design.tags.map(&:name)
    json.tags tags

    image_urls = design.images.map { |image| { 'url': rails_blob_url(image), 'index': rails_blob_url(image).split('/')[8].to_i } }
    sort_image = image_urls.select { |image| image[:index] == 0 }[0][:url] if design.images.attached?
    json.image sort_image
  end
end
