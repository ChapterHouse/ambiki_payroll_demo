InlineSvg.configure do |config|
  config.asset_file = InlineSvg::CachedAssetFile.new(
    paths: [
      "#{Rails.root}/public/icons"
    ],
    filters: /\.svg/
  )
  config.svg_not_found_css_class = 'svg-not-found'
end