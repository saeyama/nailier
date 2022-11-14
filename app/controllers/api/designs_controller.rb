# frozen_string_literal: true

class Api::DesignsController < ApplicationController
  before_action :set_design, only: %i[show edit update]
  skip_before_action :verify_authenticity_token
  def index
    @designs = Design.with_attached_images
    @designs = Design.with_attached_videos
  end

  def show; end

  def new
    @design = Design.new
  end

  def edit; end

  def create
    @design = Design.new(design_params)
    @design.attach_blob(image_data_urls)
    if @design.save
      render json: @design, status: :created
    else
      render json: @design.errors, status: :unprocessable_entity
    end
  end

  def update
    @design.attach_blob(image_data_urls)
    @design.attach_blob(video_data_urls)
    if @design.update(design_params)
      render json: { status: 'SUCCESS', data: @design }
    else
      render json: { status: 'ERROR', data: @design.errors }
    end
  end

  private

  def design_params
    params.require(:design).permit(
      :title, :nail_part, :description,
      colors_attributes: %i[lame hex_number id _destroy],
      parts_attributes: %i[name size quantity hex_number],
      tags_attributes: %i[name id],
      design_tags_attributes: %i[id _destroy],
      youtube_videos_attributes: %i[access_code id _destroy],
      images_attachments_attributes: %i[id _destroy],
      videos_attachments_attributes: %i[id _destroy]
    )
  end

  def image_data_urls
    params.require(:design).permit(images: [])[:images]
  end

  def video_data_urls
    params.require(:design).permit(videos: [])[:videos]
  end

  def set_design
    @design = Design.find(params[:id])
  end
end
