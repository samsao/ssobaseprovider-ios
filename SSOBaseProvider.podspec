
Pod::Spec.new do |s|

  s.name         = "SSOBaseProvider"
  s.version      = "0.3"
  s.summary      = "Methods to remove boiler plate code for UICollectionView and UITableView."
  s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE" }
  s.author             = { "Samsao" => "dev@samsaodev.com" }
  s.social_media_url   = "http://twitter.com/SamsaoDev"
  s.homepage           = "http://www.samsaodev.com"
   s.platform     = :ios
   s.platform     = :ios, "7.0"

  s.source       = { :git => "https://gitlab.samsaodev.com/ios-development/SSOBaseProvider.git", :tag =>  s.version.to_s }

  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"

  s.requires_arc = true
end
