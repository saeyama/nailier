# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Design, type: :model do
  let(:user) { create(:user) }
  let(:design) { build(:design, user: user) }

  it 'タイトル・ネイルパート・メモが有効である' do
    expect(design).to be_valid
  end

  it 'タイトルが無い場合、無効である' do
    design.title = nil
    expect(design).to be_invalid
  end

  it 'ネイルパートが無い場合、無効である' do
    design.nail_part = nil
    expect(design).to be_invalid
  end

  context '画像を登録する場合' do
    it '画像が5MGまでなら有効な状態である' do
      image = build(:design, :with_5mg_jpg_image, user: user)
      expect(image).to be_valid
    end

    it '画像が5MG超だと無効な状態である' do
      image = create(:design, :with_10mg_jpg_image, user: user)
      expect(image).to be_invalid
    end

    it '画像の拡張子がjpeg、jpg、png以外だと無効な状態である' do
      image = create(:design, :with_pdf_image, user: user)
      expect(image).to be_invalid
    end

    it '画像が8枚以下であれば有効である' do
      images = create(:design, :with_8_images, user: user)
      expect(images).to be_valid
    end

    it '画像が9枚以上だと無効である' do
      images = create(:design, :with_9_images, user: user)
      expect(images).to be_invalid
    end
  end
end
