# frozen_string_literal: true

FactoryBot.define do
  factory :design do
    title { 'ワンカラー' }
    nail_part { 'ハンド' }
    description { 'ベースを塗りカラーを2回塗りトップを塗る' }
    created_at { '2023-01-11T11:11:11.111+09:00' }
    association :user

    trait :with_child_model do
      after(:create) do |design|
        create(:youtube_video, design: design)
        create(:part, design: design)
        create(:color, design: design)
        create(:design_tag, design: design, tag: create(:tag))
      end
    end

    trait :with_new_design do
      title { 'グラデーション' }
      description { 'ベースを塗りカラーを爪半分に塗りクリアで伸ばすのを2回繰り返しトップを塗る' }
      created_at { '2023-01-22T22:22:22.222+09:00' }
      after(:create) do |design|
        create(:design_tag, design: design, tag: create(:tag, :add_tag))
      end
    end

    trait :with_5mg_jpg_image do
      after(:create) do |design|
        file_path = Rails.root.join('spec/factories/files/test-5mg.jpg')
        file = Rack::Test::UploadedFile.new(file_path, 'image/jpeg')
        design.images.attach(file)
      end
    end

    trait :with_10mg_jpg_image do
      after(:create) do |design|
        file_path = Rails.root.join('spec/factories/files/test-10mg.jpg')
        file = Rack::Test::UploadedFile.new(file_path, 'image/jpeg')
        design.images.attach(file)
      end
    end

    trait :with_pdf_image do
      after(:create) do |design|
        file_path = Rails.root.join('spec/factories/files/test.pdf')
        file = Rack::Test::UploadedFile.new(file_path, 'application/pdf')
        design.images.attach(file)
      end
    end

    trait :with_8_images do
      after(:create) do |design|
        8.times do
          file_path = Rails.root.join('spec/factories/files/test-5mg.jpg')
          file = Rack::Test::UploadedFile.new(file_path, 'image/jpeg')
          design.images.attach(file)
        end
      end
    end

    trait :with_9_images do
      after(:create) do |design|
        9.times do
          file_path = Rails.root.join('spec/factories/files/test-5mg.jpg')
          file = Rack::Test::UploadedFile.new(file_path, 'image/jpeg')
          design.images.attach(file)
        end
      end
    end
  end
end
