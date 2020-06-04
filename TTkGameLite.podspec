Pod::Spec.new do |spec|

  spec.name         = "TTkGameLite"
  spec.version      = "1.0.0"
  spec.summary      = "TTkGame SDK for games"
  
  spec.description  = <<-DESC
  TTkGame SDK for games
  Convenient game access
  DESC

  spec.homepage     = "https://github.com/ToTokGames/ToTokGameSDK-iOS"
  spec.license      = { :type => "MIT" }
  spec.author             = { "ToTokGames Team" => "huqingping@totok.ai" }
  
  spec.platform     = :ios, "9.0"
  spec.ios.deployment_target = "9.0"
  
  spec.source       = { :git => "https://github.com/ToTokGames/ToTokGameSDK-iOS.git", :tag => "TTkGameLite-1.0.0" }

  spec.requires_arc = true
  spec.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  
  spec.static_framework = true
  spec.libraries = 'sqlite3'
  spec.frameworks = 'UIKit', 'StoreKit', 'GameKit', 'WebKit', 'UserNotifications', 'Photos', 'ImageIO', 'Foundation', 'CoreFoundation', 'QuartzCore', 'CoreGraphics', 'AVFoundation', 'CoreTelephony', 'Security', 'AuthenticationServices'
    
  spec.subspec 'Core' do |cr|
      cr.vendored_framework = 'SDK/TTkGameLite/Core/TTkGameSDK.framework'
      cr.resource = 'SDK/TTkGameLite/Core/TTkGame.bundle'
  end
  
  spec.subspec 'Analytics' do |analy|
      analy.source_files = 'SDK/TTkGameLite/SocialLibraries/TTGCAnalytics'
      analy.vendored_library = 'SDK/TTkGameLite/SocialLibraries/TTGCAnalytics/libTTGCAnalytics.a'
      analy.dependency 'TTkGameLite/Core'
      analy.dependency 'Firebase/Analytics'
      analy.dependency 'Firebase/DynamicLinks'
  end

end
