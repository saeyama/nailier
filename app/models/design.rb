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

  def file_attach(file_type, image_blob)
    file_type.attach(
      io: image_blob.to_io,
      filename: Time.zone.now,
      content_type: image_blob.mime_type
    )
  end

  def attach_blob(image_data_urls)
    return if image_data_urls.blank?

    image_data_urls.map do |image_data_url|
      image_blob = ImageBlob.new(image_data_url)
      if image_data_url.start_with?('data:image')
        file_attach(images, image_blob)
      elsif image_data_url.start_with?('data:video')
        file_attach(videos, image_blob)
      end
    end
  end
end
