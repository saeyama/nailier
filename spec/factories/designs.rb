# frozen_string_literal: true

FactoryBot.define do
  factory :design do
    title { 'ワンカラー' }
    nail_part { 'ハンド' }
    description { 'ワンカラーのメモ' }
    created_at { '2023-01-11T11:11:11.111+09:00' }
  end
end
