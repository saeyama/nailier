json.set! :designs do
  json.array! @designs do |design|
    json.extract! design, :id, :title
    created_at = design.created_at.strftime('%Y %m %d %H:%M')
    updated_at = design.updated_at.strftime('%Y %m %d %H:%M')
    json.created_at created_at
    json.updated_at updated_at

    image_urls = design.images.map { |image| rails_blob_url(image) }
    filenames = image_urls.map {|image_url| image_url.split('/')[8].to_i}
    sort_images = filenames.map { |i| image_urls[i - 1] }
    json.image sort_images[0] if design.images.attached?

    # json.images rails_blob_url(design.images[0]) if design.images.attached?
  end
end
