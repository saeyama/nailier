# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tag, type: :model do
  let!(:tag) { create(:tag) }

  it 'タグ名が有効である' do
    expect(tag).to be_valid
  end

  it 'タグ名が重複していると無効である' do
    new_tag = build(:tag)
    expect(new_tag).to be_invalid
  end
end
