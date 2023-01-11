# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Design, type: :model do
  let(:user) { create(:user) }
  let(:design) { build(:design, user: user) }

  it 'タイトル・ネイルパートが有効である' do
    design.description = nil
    expect(design).to be_valid
  end
end
