json.set! :designs do
  json.array! @designs do |design|
    json.extract! design, :id, :title, :nail_part, :description
    create_at = design.created_at.strftime('%Y %m %d %H:%M')
    updated_at = design.updated_at.strftime('%Y %m %d %H:%M')
    json.created_at create_at
    json.updated_at updated_at
  end
end
