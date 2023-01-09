# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InquiryMailer, type: :mailer do
  let(:inquiry) { FactoryBot.build(:inquiry) }
  let(:mail) { InquiryMailer.incoming(inquiry) }

  describe 'お問い合わせ' do
    it '用件が設定されること' do
      expect(mail.subject).to eq('[nailier] お問い合わせ')
    end

    it '送信先が設定されること' do
      expect(mail.to).to eq([ENV['TOMAIL']])
    end

    it '差出人が設定されること' do
      expect(mail.from).to eq(['noreply@nailier.net'])
    end

    it '返信先が設定されること' do
      expect(mail.reply_to).to eq(['alice@example.com'])
    end

    it 'お問い合わせ内容が設定されること' do
      expect(mail.body.to_s).to include 'nailierについての問い合わせ内容'
    end
  end
end
