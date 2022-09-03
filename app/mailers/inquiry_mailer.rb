# frozen_string_literal: true

class InquiryMailer < ApplicationMailer
  def incoming(inquiry)
    @inquiry = inquiry
    mail to: ENV['TOMAIL'], reply_to: @inquiry.email, subject: '[nailier] お問い合わせ'
  end
end
