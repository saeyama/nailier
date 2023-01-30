# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Part, type: :model do
  let(:part) { create(:part) }

  it 'パーツ名・サイズ・個数・HEX番号が有効である' do
    expect(part).to be_valid
  end

  it 'パーツ名が無い場合、無効である' do
    part.name = nil
    expect(part).to be_invalid
  end

  it '個数が0の場合、無効である' do
    part.quantity = 0
    expect(part).to be_invalid
  end
end
