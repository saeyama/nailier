# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'サインアップ' do
    before do
      visit root_path
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
      expect(page).to have_current_path users_thanks_path
    end

    it 'アカウント名が重複している場合はアカウント登録ができない' do
      user = create(:user)
      fill_in 'アカウント名', with: user.account_name
      fill_in 'メールアドレス', with: 'bob@example.com'
      fill_in 'パスワード', with: user.password
      fill_in 'パスワード（確認用）', with: user.password
      click_button 'アカウントを登録'
      expect(page).not_to have_content('アカウント登録完了')
      expect(page).to have_current_path user_registration_path
    end

    it 'メールアドレスが重複している場合はアカウント登録ができない' do
      user = create(:user)
      fill_in 'アカウント名', with: 'bob'
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      fill_in 'パスワード（確認用）', with: user.password
      click_button 'アカウントを登録'
      expect(page).not_to have_content('アカウント登録完了')
      expect(page).to have_current_path user_registration_path
    end

    it 'パスワードが8文字以下の場合はアカウント登録ができない' do
      user = build(:user)
      fill_in 'アカウント名', with: user.account_name
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: '1234567'
      fill_in 'パスワード（確認用）', with: '1234567'
      click_button 'アカウントを登録'
      expect(page).not_to have_content('アカウント登録完了')
      expect(page).to have_current_path user_registration_path
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
      expect(page).to have_selector('h1', text: 'ネイルデザインリスト')
      expect(page).to have_current_path designs_path
    end

    it 'メールアドレスが未入力の場合はログインができない' do
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).not_to have_content('ネイルデザインリスト')
      expect(page).to have_current_path new_user_session_path
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

    it 'ログインをしていればアカウント情報を編集できる' do
      visit edit_user_registration_path
      fill_in 'メールアドレス', with: 'bob@example.com'
      fill_in '現在のパスワード', with: user.password
      click_button 'アカウントを更新'
      expect(page).to have_content('アカウント情報')
      expect(page).to have_current_path my_account_path
    end

    it 'ログインをしていればアカウント情報を削除できる' do
      visit my_account_path
      click_link 'アカウントを削除'
      expect(page).to have_content('退会のお手続き')
      click_link '退会する'
      expect(page.accept_confirm).to eq '本当によろしいですか？'
      expect(page).to have_content('退会手続完了')
      expect(page).to have_current_path users_withdrawal_path
    end
  end
end
