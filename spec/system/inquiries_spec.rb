# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'inquiries', type: :system do
  let(:inquiry) { FactoryBot.build(:inquiry) }

  describe 'お問い合わせ機能' do
    it '全ての項目を入力すれば送信できる' do
      visit root_path
      expect(page).to have_content('お問い合わせ')
      visit new_inquiry_path
      fill_in '件名', with: inquiry.title
      fill_in 'お名前', with: inquiry.name
      fill_in 'メールアドレス', with: inquiry.email
      fill_in 'お問い合わせ内容', with: inquiry.description
      click_button '送信'
      expect(page).to have_content('お問い合わせを承りました。')
    end

    it '空白がある場合は送信できない' do
      visit root_path
      expect(page).to have_content('お問い合わせ')
      visit new_inquiry_path
      fill_in '件名', with: ''
      fill_in 'お名前', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'お問い合わせ内容', with: ''
      click_button '送信'
      expect(page).not_to have_content('お問い合わせを承りました。')
    end
  end
end
