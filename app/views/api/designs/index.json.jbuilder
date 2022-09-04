json.set! :designs do
  json.array! @designs do |design|
    json.extract! design, :id, :title, :nail_part, :description
  end
end
