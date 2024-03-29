# frozen_string_literal: true

unless Rails.env.production?
  2.times do |i|
    User.create!(
      account_name: "user#{i + 1}",
      email: "user#{i + 1}@example.com",
      password: "password#{i + 1}"
    )
  end

  User.all.each do |user|
    5.times do |i|
      hand_design =
        Design.create!(
          user_id: user.id, title: "title#{i + 1}", nail_part: 'ハンド', description: "description#{i + 1}",
          colors_attributes: [{ lame: true, hex_number: '#000000' }, { lame: false, hex_number: '#FFFFFF' }],
          parts_attributes: [
            { name: 'ラインストーン', size: 'pp21', quantity: 1, hex_number: '#000000' },
            { name: 'Vカットストーン', size: 'ss24', quantity: 1, hex_number: '#FFFFFF' }
          ],
          tags_attributes: [{ name: 'tag1' }, { name: 'tag2' }], youtube_videos_attributes: [{ access_code: 'MQJU9quj3l4' }, { access_code: 'N2iDvU2HjQk' }]
        )
      hand_design.images.attach(io: File.open(Rails.root.join('app/assets/images/nail-sample1.jpg')), filename: '0')
      hand_design.images.attach(io: File.open(Rails.root.join('app/assets/images/nail-sample2.jpg')), filename: '1')
    end

    Design.create!(
      user_id: user.id, title: 'title6', nail_part: 'フット', description: 'description6',
      colors_attributes: [
        { lame: true, hex_number: '#000000' }, { lame: false, hex_number: '#FFFFFF' }
      ],
      tags_attributes: [{ name: 'tag1' }, { name: 'tag3' }],
      youtube_videos_attributes: [{ access_code: 'MQJU9quj3l4' }, { access_code: 'N2iDvU2HjQk' }]
    )
  end
end
