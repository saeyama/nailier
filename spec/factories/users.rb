# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    account_name { 'user1' }
    email { 'user1@example.com' }
    password { 'password1' }
  end
end
