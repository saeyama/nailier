# frozen_string_literal: true

require 'rails_helper'

RSpec.describe YoutubeVideo, type: :model do
  let(:youtube_video) { create(:youtube_video) }

  it 'アカウントコードが有効である' do
    expect(youtube_video).to be_valid
  end

  it 'アカウントコードが無い場合、無効である' do
    youtube_video.access_code = nil
    expect(youtube_video).to be_invalid
  end
end
