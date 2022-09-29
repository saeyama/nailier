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
  has_many :youtube_videos, dependent: :destroy
  accepts_nested_attributes_for :youtube_videos, allow_destroy: true
  has_many :design_tags, dependent: :destroy
  has_many :tags, through: :design_tags
  accepts_nested_attributes_for :tags
  def file_attach(file_type, file_blob)
    file_type.attach(
      io: file_blob.to_io,
      filename: Time.zone.now,
      content_type: file_blob.mime_type
    )
  end

  def attach_blob(file_data_urls)
    return if file_data_urls.blank?

    file_data_urls.map do |file_data_url|
      file_blob = FileBlob.new(file_data_url)
      if file_data_url.start_with?('data:image')
        file_attach(images, file_blob)
      elsif file_data_url.start_with?('data:video')
        file_attach(videos, file_blob)
      end
    end
  end
end
