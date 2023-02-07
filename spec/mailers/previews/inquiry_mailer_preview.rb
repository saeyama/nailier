# frozen_string_literal: true

class InquiryMailerPreview < ActionMailer::Preview
  def welcome
    inquiry = Inquiry.new(title: 'nailierについて', name: 'alice', email: 'alice@example.com', description: 'nailierについての問い合わせ内容')
    InquiryMailer.incoming(inquiry)
  end
end
