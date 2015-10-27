Pod::Spec.new do |s|
    s.name             = "OceanView"
    s.version          = "0.1.0"
    s.summary          = "OceanView is a demo project representation of the sea. It's written in pure swift."
    s.homepage         = "https://github.com/shushutochako/OceanView"
    s.license          = 'MIT'
    s.author           = { "shushutochako" => "shushutochako22@gmail.com" }
    s.source           = { :git => "https://github.com/shushutochako/OceanView.git", :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/shushutochako'

    s.platform     = :ios, '8.0'
    s.requires_arc = true

    s.source_files = 'Pod/Classes/**/*'
end
