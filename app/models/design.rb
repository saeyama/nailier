# frozen_string_literal: true

class Design < ApplicationRecord
  validates :title, presence: true
  validates :nail_part, presence: true
  has_many_attached :images
  has_many_attached :videos
  has_many :colors, dependent: :destroy
  accepts_nested_attributes_for :colors, allow_destroy: true
  has_many :parts, dependent: :destroy
  accepts_nested_attributes_for :parts, allow_destroy: true

  def attach_blob(image_data_urls)
    image_data_urls.map do |image_data_url|
      image_blob = ImageBlob.new(image_data_url)
      images.attach(
        io: image_blob.to_io,
        filename: Time.zone.now,
        content_type: image_blob.mime_type
      )
    end
  end
end
