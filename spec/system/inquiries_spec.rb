# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Inquiries', type: :system do
  describe '送信' do
    let(:inquiry) { build(:inquiry) }

    before do
      visit new_inquiry_path
    end

    it '件名・お名前・メールアドレス・お問い合わせ内容が入力されていれば送信できる' do
      fill_in '件名', with: inquiry.title
      fill_in 'お名前', with: inquiry.name
      fill_in 'メールアドレス', with: inquiry.email
      fill_in 'お問い合わせ内容', with: inquiry.description
      click_button '送信'
      expect(page).to have_content('お問い合わせを承りました。')
      expect(page).to have_current_path inquiries_thanks_path
    end

    it '空白が一つでもある場合は送信できない' do
      fill_in '件名', with: inquiry.title
      fill_in 'お名前', with: inquiry.name
      fill_in 'メールアドレス', with: ''
      fill_in 'お問い合わせ内容', with: inquiry.description
      click_button '送信'
      expect(page).not_to have_content('お問い合わせを承りました。')
      expect(page).to have_current_path new_inquiry_path
    end
  end
end
