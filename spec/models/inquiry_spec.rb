# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  let(:inquiry) { FactoryBot.build(:inquiry) }

  describe 'お問い合わせ' do
    it '有効な状態であること' do
      expect(inquiry).to be_valid
    end
    it '件名がなければ無効な状態であること' do
      inquiry.title = nil
      expect(inquiry).not_to be_valid
    end
    it 'お名前がなければ無効な状態であること' do
      inquiry.name = nil
      expect(inquiry).not_to be_valid
    end
    it 'メールアドレスがなければ無効な状態であること' do
      inquiry.email = nil
      expect(inquiry).not_to be_valid
    end
    it 'お問い合わせ内容がなければ無効な状態であること' do
      inquiry.description = nil
      expect(inquiry).not_to be_valid
    end
  end
end
