# frozen_string_literal: true

class InquiriesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)

    if @inquiry.save
      InquiryMailer.incoming(@inquiry).deliver_later
      redirect_to thanks_inquiries_path
    else
      render :new
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:title, :name, :email, :description)
  end
end
