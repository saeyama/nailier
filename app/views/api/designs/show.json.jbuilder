json.extract! @design, :id, :title, :description, :nail_part
urls = @design.images.map { |image| rails_blob_url(image) }
json.images urls if @design.images.attached?
