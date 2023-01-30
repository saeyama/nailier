# frozen_string_literal: true

FactoryBot.define do
  factory :part do
    name { 'ラインストーン' }
    size { 'pp21' }
    quantity { 1 }
    hex_number { '#000000' }
    association :design
  end
end
