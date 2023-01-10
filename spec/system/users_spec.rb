# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'サインアップ' do
    before do
      visit root_path
      expect(page).to have_content('アカウントを登録')
      visit new_user_registration_path
    end

    it 'アカウント名・メールアドレス・パスワード・パスワード（確認用）が正しく入力されていればアカウント登録ができる' do
      user = build(:user)
      fill_in 'アカウント名', with: user.account_name
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      fill_in 'パスワード（確認用）', with: user.password
      click_button 'アカウントを登録'
      expect(page).to have_content('アカウント登録完了')
      expect(current_path).to eq users_thanks_path
    end

    it 'メールアドレスが重複している場合はアカウント登録ができない' do
      user = create(:user)
      fill_in 'アカウント名', with: 'bob'
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      fill_in 'パスワード（確認用）', with: user.password
      click_button 'アカウントを登録'
      expect(page).not_to have_content('アカウント登録完了')
      expect(current_path).to eq users_path
    end

    it 'アカウント名が重複している場合はアカウント登録ができない' do
      user = create(:user)
      fill_in 'アカウント名', with: user.account_name
      fill_in 'メールアドレス', with: 'bob@example.com'
      fill_in 'パスワード', with: user.password
      fill_in 'パスワード（確認用）', with: user.password
      click_button 'アカウントを登録'
      expect(page).not_to have_content('アカウント登録完了')
      expect(current_path).to eq users_path
    end
  end

  describe 'ログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    it 'メールアドレス・パスワードを正しく入力した場合はログインができる' do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).to have_content('ネイルデザインリスト')
      expect(current_path).to eq designs_path
    end

    it 'メールアドレスが未入力の場合はログインができない' do
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).not_to have_content('ネイルデザインリスト')
      expect(current_path).to eq new_user_session_path
    end
  end

  describe 'アカウント情報' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    it 'ログインをしていれば編集できる' do
      visit edit_user_registration_path
      fill_in 'メールアドレス', with: 'bob@example.com'
      fill_in '現在のパスワード', with: user.password
      click_button 'アカウントを更新'
      expect(page).to have_content('アカウント情報')
      expect(current_path).to eq users_path
    end
  end
end
