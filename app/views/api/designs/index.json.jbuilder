json.set! :designs do
  json.array! @designs do |design|
    json.extract! design, :id, :title
    created_at = design.created_at.strftime('%Y %m %d %H:%M')
    updated_at = design.updated_at.strftime('%Y %m %d %H:%M')
    json.created_at created_at
    json.updated_at updated_at
    json.images rails_blob_url(design.images[0]) if design.images.attached?
  end
end
