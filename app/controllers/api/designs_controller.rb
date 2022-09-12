# frozen_string_literal: true

class Api::DesignsController < ApplicationController
  before_action :set_design, only: %i[show]
  skip_before_action :verify_authenticity_token
  def index
    @designs = Design.all
  end

  def show; end

  def new
    @design = Design.new
  end

  def create
    @design = Design.new(design_params)
    if @design.save
      render json: @design, status: :created
    else
      render json: @design.errors, status: :unprocessable_entity
    end
  end

  private

  def design_params
    params.require(:design).permit(:title, :nail_part, :description)
  end

  def set_design
    @design = Design.find(params[:id])
  end
end
