# frozen_string_literal: true

FactoryBot.define do
  factory :youtube_video do
    access_code { 'MQJU9quj3l4' }
    association :design
  end
end
