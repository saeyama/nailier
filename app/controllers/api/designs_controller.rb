# frozen_string_literal: true

class Api::DesignsController < ApplicationController
  before_action :set_design, only: %i[show edit update destroy]
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound do |_exception|
    render json: { error: '404 not found' }, status: :not_found
  end

  def index
    @designs = current_user.designs.order(updated_at: :DESC).with_attached_images
  end

  def show; end

  def new
    @design = Design.new
  end

  def edit; end

  def create
    Design.transaction do
      @design = current_user.designs.new(design_params)
      @design.attach_blob(image_data_urls)
      @design.save!
    end
    if @design.persisted?
      render json: @design, status: :created
    else
      render json: @design.errors, status: :unprocessable_entity
    end
  end

  def update
    Design.transaction do
      @design.attach_blob(image_data_urls) if @design.images.map(&:blank?)
      @design.images_set(sort_image_ids) if @design.images.attached?
      @design.update!(design_params)
      @design.update!(updated_at: Time.zone.now) unless @design.changed?
    end
    if @design.persisted?
      render json: { status: 'SUCCESS', data: @design }
    else
      render json: { status: 'ERROR', data: @design.errors }
    end
  end

  def destroy
    @design.images.map(&:purge_later)
    @design.destroy
  end

  private

  def design_params
    params.require(:design).permit(
      :title, :nail_part, :description,
      colors_attributes: %i[lame hex_number id _destroy],
      parts_attributes: %i[name size quantity hex_number id _destroy],
      tags_attributes: %i[name id],
      design_tags_attributes: %i[id _destroy],
      youtube_videos_attributes: %i[access_code id _destroy],
      images_attachments_attributes: %i[id _destroy]
    )
  end

  def image_data_urls
    params.require(:design).permit(images: [])[:images]
  end

  def set_design
    @design = current_user.designs.find(params[:id])
  end

  def sort_image_ids
    params.require(:design).permit(sort_image_ids: [])[:sort_image_ids]
  end
end
