# frozen_string_literal: true

class Design < ApplicationRecord
  belongs_to :user

  has_many_attached :images
  accepts_nested_attributes_for :images_attachments, allow_destroy: true
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

  validates :title, presence: true
  validates :nail_part, presence: true
  validates :images, attached: true, content_type: ['image/jpeg', 'image/jpg', 'image/png'], size: { between: 1.kilobyte..5.megabytes }
  validates :images, limit: { min: 0, max: 8 }

  def attach_blob(image_data_urls)
    return if image_data_urls.blank?

    image_data_urls.map.with_index do |image_data_url, index|
      image_blob = ImageBlob.new(image_data_url)
      images.attach(
        io: image_blob.to_io,
        filename: index,
        content_type: image_blob.mime_type
      )
    end
  end

  def tags_attributes=(tag_attributes)
    tag_attributes.uniq.each do |tag_params|
      next if tag_params[:name].blank?

      tag = Tag.find_or_create_by(tag_params)
      tags << tag if tags.where(name: tag[:name]).blank?
    end
  end

  def images_set(sort_image_ids)
    return unless sort_image_ids

    sort_images = SortImages.new(sort_image_ids)
    sort_images.temporary_new_ids(sort_images.blank_ids) if sort_image_ids.include?('')
    sort_images.index_of_ids.each.with_index do |id, index|
      images[id].blob.update(filename: index)
    end
  end
end
