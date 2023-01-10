# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'アカウント名・メールアドレス・パスワードが有効である' do
    expect(build(:user)).to be_valid
  end

  it 'メールアドレスが重複していると無効である' do
    create(:user)
    new_user = build(:user, account_name: 'bob')
    expect(new_user).not_to be_valid
  end

  it 'アカウント名が重複していると無効である' do
    create(:user)
    new_user = build(:user, email: 'bob@example.com')
    expect(new_user).not_to be_valid
  end
end
