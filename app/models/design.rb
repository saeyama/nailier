# frozen_string_literal: true

class Design < ApplicationRecord
  validates :title, presence: true
  validates :nail_part, presence: true
  has_many_attached :images
  accepts_nested_attributes_for :images_attachments, allow_destroy: true
  has_many_attached :videos
  accepts_nested_attributes_for :videos_attachments, allow_destroy: true
  has_many :colors, dependent: :destroy
  accepts_nested_attributes_for :colors, allow_destroy: true
  has_many :parts, dependent: :destroy
  accepts_nested_attributes_for :parts, allow_destroy: true
  has_many :youtube_videos, dependent: :destroy
  accepts_nested_attributes_for :youtube_videos, allow_destroy: true
  has_many :design_tags, dependent: :destroy
  has_many :tags, through: :design_tags
  accepts_nested_attributes_for :design_tags, allow_destroy: true
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

  def tags_attributes=(tag_attributes)
    tag_attributes.uniq.each do |tag_params|
      next if tag_params[:name].blank?

      tag = Tag.find_or_create_by(tag_params)
      tags << tag if tags.where(name: tag[:name]).blank?
    end
  end
end
