# frozen_string_literal: true

5.times do |i|
  hand_design =
    Design.create!(
      title: "title#{i + 1}",
      nail_part: 'ハンド',
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
  hand_design.images.attach(io: File.open(Rails.root.join('app/assets/images/nail-sample1.jpg')), filename: '0')
  hand_design.images.attach(io: File.open(Rails.root.join('app/assets/images/nail-sample2.jpg')), filename: '1')
  hand_design.videos.attach(io: File.open(Rails.root.join('app/assets/videos/nail.mp4')), filename: '0')
end

foot_design =
  Design.create!(
    title: 'title6',
    nail_part: 'フット',
    description: 'description6',
    colors_attributes: [
      { lame: true, hex_number: '#000000' }, { lame: false, hex_number: '#FFFFFF' }
    ],
    tags_attributes: [
      { name: 'tag1' }, { name: 'tag3' }
    ],
    youtube_videos_attributes: [
      { access_code: 'MQJU9quj3l4' }, { access_code: 'N2iDvU2HjQk' }
    ]
  )
foot_design.videos.attach(io: File.open(Rails.root.join('app/assets/videos/nail.mp4')), filename: '0')
