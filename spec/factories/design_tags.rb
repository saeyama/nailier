# frozen_string_literal: true

FactoryBot.define do
  factory :design_tag do
    association :design
    association :tag
  end
end
