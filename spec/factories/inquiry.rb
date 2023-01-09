# frozen_string_literal: true

FactoryBot.define do
  factory :inquiry do
    title { 'nailierについて' }
    name { 'alice' }
    email { 'alice@example.com' }
    description { 'nailierについての問い合わせ内容' }
  end
end
