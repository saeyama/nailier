# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Designs', type: :system do
  let(:user) { create(:user) }

  describe '#index' do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    context 'ネイルデザインが登録されている場合' do
      let!(:design) { create(:design, user: user) }

      it 'ネイルデザインが表示される' do
        visit designs_path
        expect(page).to have_content('ネイルデザインリスト')
        expect(page).to have_content('ワンカラー')
        expect(page).to have_content('2023 01 11 11:11')
      end
    end

    context 'ネイルデザインが登録されていない場合' do
      it '登録されておりませんと表示される' do
        expect(page).to have_content('ネイルデザインリスト')
        expect(page).to have_content('登録されておりません。')
      end
    end
  end

  describe '#show' do
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    context 'ネイルデザインが登録されている場合' do
      let!(:design) { create(:design, user: user) }

      it 'ネイルデザインの登録内容が表示される' do
        visit design_path(design.id)
        expect(page).to have_content('ワンカラー')
        expect(page).to have_content('ハンド')
      end
    end
  end

  describe '#update' do
    let!(:design) { create(:design, user: user) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    it 'ネイルデザインを編集できる' do
      visit edit_design_path(design.id)
      fill_in 'title', with: 'グラデーション'
      choose 'foot'
      click_button 'ネイルデザインを更新'
      expect(page).to have_content('ネイルデザインリスト')
      expect(current_path).to eq designs_path
    end
  end

  describe '#create' do
    let(:design) { build(:design, user: user) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      click_link 'ネイルデザインを登録'
    end

    it 'タイトルの入力とネイルパートが選択されていればデザイン登録ができる' do
      visit new_design_path
      fill_in 'title', with: design.title
      choose 'foot'
      click_button 'ネイルデザインを登録'
      expect(page).to have_content('ネイルデザインリスト')
      expect(current_path).to eq designs_path
    end
  end

  describe '#destroy' do
    let(:design) { create(:design, user: user) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      click_link 'ネイルデザインを登録'
    end

    it 'ネイルデザインを削除できる' do
      visit design_path(design.id)
      click_button 'ネイルデザインを削除'
      expect(page.accept_confirm).to eq 'この操作は取り消すことはできません。本当に削除しますか？'
      expect(page).to have_content('ネイルデザインリスト')
      expect(page).to have_content('登録されておりません。')
      expect(current_path).to eq designs_path
    end
  end

  context 'ログインしていない場合' do
    it 'ログインページに遷移すること' do
      visit designs_path
      expect(page).to have_content('ログイン')
      expect(current_path).to eq new_user_session_path
    end
  end
end
