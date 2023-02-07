# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags # rubocop:disable Metrics/MethodLength
    {
      site: 'Nailier(ネイリエ)',
      title: 'Nailier(ネイリエ)',
      reverse: true,
      charset: 'utf-8',
      description: 'ネイリストのためのデザインメモ・Nailier(ネイリエ)。画像やメモをデザイン毎に簡単一まとめ&#9834;',
      og: {
        site_name: 'Nailier(ネイリエ)',
        title: :title,
        tyep: 'website',
        description: :description,
        image: image_url('ogp.png'),
        url: 'https://nailier.net/'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@saeyama_pg',
        title: :title,
        description: :description,
        image: image_url('ogp.png'),
        domain: 'https://nailier.net/'
      }
    }
  end
end
