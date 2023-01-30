# frozen_string_literal: true

FactoryBot.define do
  factory :tag do
    name { 'ワンカラーのタグ' }

    trait :add_tag do
      name { 'グラデーションのタグ' }
    end
  end
end
