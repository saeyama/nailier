# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do |i|
  design =
    Design.create!(
      title: "title#{i + 1}",
      nail_part: 'hand',
      description: "description#{i + 1}",
      colors_attributes: [
        { lame: true, hex_number: '#000000' }, { lame: false, hex_number: '#FFFFFF' }
      ],
      parts_attributes: [
        { name: 'ラインストーン', size: 'pp21', quantity: 1, hex_number: '#000000' },
        { name: 'Vカットストーン', size: 'ss24', quantity: 1, hex_number: '#FFFFFF' }
      ],
      tags_attributes: [
        { name: 'tag1' }, { name: 'tag2' }
      ],
      youtube_videos_attributes: [
        { access_code: 'MQJU9quj3l4' }, { access_code: 'N2iDvU2HjQk' }
      ]
    )
  2.times do
    design.images.attach(io: File.open(Rails.root.join('app/assets/images/nail.jpeg')), filename: 'nail.jpeg')
  end
  2.times do
    design.videos.attach(io: File.open(Rails.root.join('app/assets/videos/nail.mov')), filename: 'nail.mov')
  end
end
