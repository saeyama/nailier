# frozen_string_literal: true

class Api::DesignsController < ApplicationController
  before_action :set_design, only: %i[show]

  def index
    @designs = Design.all
  end

  def show; end

  private

  def set_design
    @design = Design.find(params[:id])
  end
end
