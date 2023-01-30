# frozen_string_literal: true

FactoryBot.define do
  factory :color do
    lame { true }
    hex_number { '#000000' }
    association :design
  end
end
