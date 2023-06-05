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
      it 'ネイルデザインの編集ページに遷移できる' do
        create(:design, user:)

        visit designs_path
        all('.nailpart-design')[0].find('.kebab-menu').click
        find('.design-edit-link').click
        expect(page).to have_content('ネイルデザインを編集')
      end

      it 'ネイルデザインを削除することができる' do
        create(:design, user:)

        visit designs_path
        all('.nailpart-design')[0].find('.kebab-menu').click
        find('.delete-design').click
        expect(page.accept_confirm).to eq 'この操作は取り消すことはできません。本当に削除しますか？'
        expect(page).to have_selector('h1', text: 'ネイルデザインリスト')
        expect(page).to have_content('登録されておりません。')
        expect(page).to have_current_path designs_path
      end

      context 'タグが登録されている場合' do
        it 'タグ検索ができる' do
          create(:design, user:)
          create(:design, :with_new_design, user:)

          visit designs_path
          expect(page.all('.nailpart-design')[0]).to have_content('グラデーション')
          expect(page.all('.nailpart-design')[0]).to have_content('2023 01 22 22:22')
          expect(page.all('.nailpart-design')[1]).to have_content('ワンカラー')
          expect(page.all('.nailpart-design')[1]).to have_content('2023 01 11 11:11')
          select 'グラデーションのタグ', from: 'design-tags'
          expect(page.all('.nailpart-design')[0]).to have_content('グラデーション')
          expect(page.all('.nailpart-design')[0]).to have_content('2023 01 22 22:22')
          expect(page.all('.nailpart-design')[1]).not_to have_content('ワンカラー')
          expect(page.all('.nailpart-design')[1]).not_to have_content('2023 01 11 11:11')
        end
      end

      context '画像登録がある場合' do
        before { create(:design, :with_5mg_jpg_image, user:) }

        it '登録した画像が表示される' do
          visit designs_path
          expect(page).to have_content('ワンカラー')
          expect(page).to have_content('2023 01 11 11:11')
          expect(page).to have_selector "img[alt = 'サムネイル画像']"
          expect(page).not_to have_content('no image')
        end
      end

      context '画像登録がない場合' do
        before { create(:design, user:) }

        it 'デフォルト画像が表示される' do
          visit designs_path
          expect(page).to have_content('ワンカラー')
          expect(page).to have_content('2023 01 11 11:11')
          expect(page).to have_content('no image')
          expect(page).not_to have_selector "img[alt = 'サムネイル画像']"
        end
      end
    end

    context 'ネイルデザインが登録されていない場合' do
      it '登録されておりませんと表示される' do
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

    context 'ネイルデザインに子モデルが登録されている場合' do
      let!(:design) { create(:design, :with_child_model, :with_5mg_jpg_image, user:) }

      it '子モデルを含めたネイルデザインの登録内容が表示される' do
        visit design_path(design.id)
        expect(page).to have_selector('.design-title', text: 'ワンカラー')
        expect(page).to have_selector('.design-nailpart', text: 'ハンド')
        expect(page).to have_selector "img[alt = '登録画像']"
        expect(page).to have_selector('.design-youtubevideos', visible: :all, text: 'MQJU9quj3l4')
        expect(page).to have_selector('.design-colors', visible: :all, text: 'true')
        expect(page).to have_selector('.design-colors', visible: :all, text: '#000000')
        expect(page).to have_selector('.design-parts', text: 'ラインストーン')
        expect(page).to have_selector('.design-parts', text: 'pp21')
        expect(page).to have_selector('.design-parts', text: '1個')
        expect(page).to have_selector('.design-parts', visible: :all, text: '#000000')
        expect(page).to have_selector('.design-description', text: 'ベースを塗りカラーを2回塗りトップを塗る')
        expect(page).to have_selector('.design-tags', text: 'ワンカラーのタグ')

        expect(page).not_to have_selector('.design-images', visible: :all, text: '登録されている画像はありません。')
        expect(page).not_to have_selector('.design-youtubevideos', visible: :all, text: '登録されているYouTube動画はありません。')
        expect(page).not_to have_selector('.design-colors', visible: :all, text: '登録されているカラーはありません。')
        expect(page).not_to have_selector('.design-parts', text: '登録されているパーツはありません。')
        expect(page).not_to have_selector('.design-description', text: '登録されているメモはありません。')
      end

      context '画像を登録している場合' do
        it '画像を拡大表示することができる' do
          visit design_path(design.id)
          expect(page).not_to have_selector('.vel-modal')
          find('div.design-images').all('img')[0].click
          expect(page).to have_selector('.vel-modal')
          find('.btn__close').click
          expect(page).not_to have_selector('.vel-modal')
        end
      end
    end

    context 'ネイルデザインに子モデルが登録されていない場合' do
      let!(:design) { create(:design, description: '', user:) }

      it 'タイトル・ネイルパートのみ表示され、メモと子モデルは表示されない' do
        visit design_path(design.id)
        expect(page).to have_selector('.design-title', text: 'ワンカラー')
        expect(page).to have_selector('.design-nailpart', text: 'ハンド')
        expect(page).not_to have_selector "img[alt = '登録画像']"
        expect(page).not_to have_selector('.design-youtubevideos', visible: :all, text: 'MQJU9quj3l4')
        expect(page).not_to have_selector('.design-colors', visible: :all, text: 'true')
        expect(page).not_to have_selector('.design-colors', visible: :all, text: '#000000')
        expect(page).not_to have_selector('.design-parts', text: 'ラインストーン')
        expect(page).not_to have_selector('.design-parts', text: 'pp21')
        expect(page).not_to have_selector('.design-parts', text: '1個')
        expect(page).not_to have_selector('.design-parts', visible: :all, text: '#000000')
        expect(page).not_to have_selector('.design-description', text: 'ベースを塗りカラーを2回塗りトップを塗る')
        expect(page).not_to have_selector('.design-tags', text: 'ワンカラーのタグ')

        expect(page).to have_selector('.design-images', visible: :all, text: '登録されている画像はありません。')
        expect(page).to have_selector('.design-youtubevideos', visible: :all, text: '登録されているYouTube動画はありません。')
        expect(page).to have_selector('.design-colors', visible: :all, text: '登録されているカラーはありません。')
        expect(page).to have_selector('.design-parts', text: '登録されているパーツはありません。')
        expect(page).to have_selector('.design-description', text: '登録されているメモはありません。')
      end
    end
  end

  describe '#update' do
    let!(:design) { create(:design, user:) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    it 'ネイルデザインを編集できる' do
      visit edit_design_path(design.id)
      fill_in 'design-title', with: 'グラデーション'
      attach_file 'design-image', Rails.root.join('spec/factories/files/test-1mg.jpg'), make_visible: true
      click_button 'ネイルデザインを更新'
      expect(page).to have_selector('h1', text: 'ネイルデザインリスト')
      expect(page).to have_content('グラデーション')
      expect(page).to have_selector "img[alt = 'サムネイル画像']"
      expect(page).to have_current_path designs_path
    end
  end

  describe '#create' do
    let(:design) { build(:design, user:) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      find('.new-design-link-btn').click
      visit new_design_path
    end

    it 'タイトルの入力とネイルパートが選択されていればデザイン登録ができる' do
      fill_in 'design-title', with: design.title
      expect(page).to have_checked_field with: 'ハンド'
      find('.foot').click
      expect(page).to have_checked_field with: 'フット'
      click_button 'ネイルデザインを登録'
      expect(page).to have_selector('h1', text: 'ネイルデザインリスト')
      expect(page).to have_current_path designs_path
    end

    context '画像をデザインに登録する場合' do
      it '画像が5MG以下で拡張子がjpeg、jpg、pngであれば、複数の画像のアップロードとD&Dができる状態でデザインに登録できる' do
        file_path1 = Rails.root.join('spec/factories/files/test-1mg.jpg')
        file_path2 = Rails.root.join('spec/factories/files/test-5mg.jpg')
        fill_in 'design-title', with: design.title
        find('.foot').click
        expect(page).to have_checked_field with: 'フット'
        attach_file 'design-image', [file_path1, file_path2], make_visible: true
        find('.files').all('div.item')[0].drag_to find('.files').all('div.item')[1]
        click_button 'ネイルデザインを登録'
        expect(page).to have_selector('h1', text: 'ネイルデザインリスト')
        expect(page).to have_current_path designs_path
      end

      it '5MG超の画像はデザインに登録できない' do
        file_path = Rails.root.join('spec/factories/files/test-10mg.jpg')
        attach_file 'design-image', file_path, make_visible: true
        expect(page.accept_confirm).to eq '5MGを超えた画像はアップロードできません。'
      end

      it '拡張子がjpeg、jpg、png以外の画像はデザインに登録できない' do
        file_path = Rails.root.join('spec/factories/files/test.gif')
        attach_file 'design-image', file_path, make_visible: true
        expect(page.accept_confirm).to eq 'jpeg・jpg・png 以外は登録できません。'
      end
    end

    context 'タグをデザインに登録する場合' do
      it 'タグ名をデザインに登録できる' do
        fill_in 'design-title', with: design.title
        find('.foot').click
        expect(page).to have_checked_field with: 'フット'
        fill_in 'design-tag', with: 'タグ'
        within '.tags-input' do
          click_button '決定'
        end
        click_button 'ネイルデザインを登録'
        expect(page).to have_selector('h1', text: 'ネイルデザインリスト')
        expect(page).to have_current_path designs_path
      end
    end

    context 'YouTube動画をデザインに登録する場合' do
      it 'アカウントコードをデザインに登録できる' do
        visit new_design_path
        fill_in 'design-title', with: design.title
        find('.foot').click
        expect(page).to have_checked_field with: 'フット'
        fill_in 'design-youtube', with: 'https://www.youtube.com/watch?v=MQJU9quj3l4'
        within '.youtube-input' do
          click_button '決定'
        end
        click_button 'ネイルデザインを登録'
        expect(page).to have_selector('h1', text: 'ネイルデザインリスト')
        expect(page).to have_current_path designs_path
      end
    end

    context 'パーツをデザインに登録する場合' do
      it 'パーツ名・サイズ・個数・カラーをデザインに登録できる' do
        visit new_design_path
        fill_in 'design-title', with: design.title
        find('.foot').click
        expect(page).to have_checked_field with: 'フット'
        find('.show-part-content').click
        fill_in 'design-part-name', with: 'ラインストーン'
        fill_in 'design-part-size', with: 'ss20'
        expect(find('.parts-input')).to have_content(1)
        fill_in 'design-part-quantity', with: 6
        find('.show-part-color-content').click
        find('ul.part-hexnumber').all('li')[0].click
        within '.parts-input' do
          click_button '決定'
        end
        click_button 'ネイルデザインを登録'
        expect(page).to have_selector('h1', text: 'ネイルデザインリスト')
        expect(page).to have_current_path designs_path
      end

      it 'パーツ名が無いとデザインに登録できない' do
        visit new_design_path
        fill_in 'design-title', with: design.title
        find('.foot').click
        expect(page).to have_checked_field with: 'フット'
        find('.show-part-content').click
        fill_in 'design-part-name', with: ''
        fill_in 'design-part-size', with: 'ss20'
        fill_in 'design-part-quantity', with: 6
        find('.show-part-color-content').click
        find('ul.part-hexnumber').all('li')[0].click
        within '.parts-input' do
          click_button '決定'
        end
        expect(page.accept_confirm).to eq 'パーツ名は登録必須です。'
      end
    end

    context 'カラーをデザインに登録する場合' do
      it 'カラーピッカーでカラーをデザインに登録できる' do
        fill_in 'design-title', with: design.title
        find('.foot').click
        expect(page).to have_checked_field with: 'フット'
        find('.show-color-content').click
        expect(find('.color-lame')).to have_checked_field with: 'false', visible: :all
        find('.lame-toggle').click
        expect(find('.color-lame')).to have_checked_field with: 'true', visible: :all
        find('.vc-input__input').set('#000000')
        within '.colors-input' do
          click_button '決定'
        end
        click_button 'ネイルデザインを登録'
        expect(page).to have_selector('h1', text: 'ネイルデザインリスト')
        expect(page).to have_current_path designs_path
      end

      it 'カラーパレットでカラーをデザインに登録できる' do
        fill_in 'design-title', with: design.title
        find('.foot').click
        expect(page).to have_checked_field with: 'フット'
        find('.show-color-content').click
        expect(find('.color-lame')).to have_checked_field with: 'false', visible: :all
        click_on 'カラーパレット'
        find('ul.color-hexnumber').all('li')[0].click
        within '.colors-input' do
          click_button '決定'
        end
        click_button 'ネイルデザインを登録'
        expect(page).to have_selector('h1', text: 'ネイルデザインリスト')
        expect(page).to have_current_path designs_path
      end
    end
  end

  describe '#destroy' do
    let(:design) { create(:design, :with_child_model, :with_5mg_jpg_image, user:) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    it 'ネイルデザインを削除できる' do
      visit design_path(design.id)
      click_button 'ネイルデザインを削除'
      expect(page.accept_confirm).to eq 'この操作は取り消すことはできません。本当に削除しますか？'
      expect(page).to have_selector('h1', text: 'ネイルデザインリスト')
      expect(page).to have_content('登録されておりません。')
      expect(page).to have_current_path designs_path
    end
  end

  context 'ログインをしていない場合' do
    it 'ログインページに遷移すること' do
      visit designs_path
      expect(page).to have_content('ログイン')
      expect(page).to have_current_path new_user_session_path
    end
  end
end
