# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Color, type: :model do
  let(:color) { create(:color) }

  it 'ラメ・HEX番号が有効である' do
    expect(color).to be_valid
  end

  it 'ラメが無い場合、無効である' do
    color.lame = nil
    expect(color).to be_invalid
  end

  it 'HEX番号が無い場合、無効である' do
    color.hex_number = nil
    expect(color).to be_invalid
  end
end
