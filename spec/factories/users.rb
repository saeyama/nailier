# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    account_name { 'alice' }
    email { 'alice@example.com' }
    # sequence(:email) { |n| "nailier#{n}@example.com" }
    password { 'password' }
  end
end
