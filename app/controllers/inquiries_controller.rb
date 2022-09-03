# frozen_string_literal: true

class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)

    if @inquiry.save
      InquiryMailer.incoming(@inquiry).deliver_later
      redirect_to inquiries_thanks_url
    else
      render :new
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:title, :name, :email, :description)
  end
end
