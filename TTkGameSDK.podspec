Pod::Spec.new do |spec|

  spec.name         = "TTkGameSDK"
  spec.version      = "1.0.8"
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
  
  spec.source       = { :git => "https://github.com/ToTokGames/ToTokGameSDK-iOS.git", :tag => "1.0.8" }

  spec.requires_arc = true
  spec.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  
  #是否使用静态库。如果podfile指明了use_frameworks!命令，但是pod仓库需要使用静态库则需要设置
  spec.static_framework = true
  spec.libraries = 'sqlite3'
  spec.frameworks = 'UIKit', 'StoreKit', 'GameKit', 'WebKit', 'UserNotifications', 'Photos', 'ImageIO', 'Foundation', 'CoreFoundation', 'QuartzCore', 'CoreGraphics', 'AVFoundation', 'CoreTelephony', 'Security', 'AuthenticationServices'
  
  spec.vendored_framework = 'SDK/TTkGameSDK/Core/TTkGameSDK.framework'
  spec.resources = 'SDK/TTkGameSDK/Core/TTkGame.bundle','SDK/TTkGameSDK/Core/TTGCProgressHUD.bundle'
  
  spec.subspec 'Core' do |cr|
      cr.vendored_framework = 'SDK/TTkGameSDK/Core/TTkGameSDK.framework'
      cr.resources = 'SDK/TTkGameSDK/Core/TTkGame.bundle','SDK/TTkGameSDK/Core/TTGCProgressHUD.bundle'
  end
  
  spec.subspec 'Facebook' do |fb|
      fb.source_files = 'SDK/TTkGameSDK/SocialLibraries/Facebook'
      fb.vendored_library = 'SDK/TTkGameSDK/SocialLibraries/Facebook/libTTGCSocialFacebook.a'
      fb.vendored_framework = 'SDK/TTkGameSDK/Core/TTkGameSDK.framework'
      fb.dependency 'FBSDKCoreKit', '~> 6.5.1'
      fb.dependency 'FBSDKLoginKit', '~> 6.5.1'
      fb.dependency 'FBSDKShareKit', '~> 6.5.1'
      fb.resources = 'SDK/TTkGameSDK/Core/TTkGame.bundle','SDK/TTkGameSDK/Core/TTGCProgressHUD.bundle'
  end
  
  spec.subspec 'Analytics' do |analy|
      analy.source_files = 'SDK/TTkGameSDK/SocialLibraries/TTGCAnalytics'
      analy.vendored_library = 'SDK/TTkGameSDK/SocialLibraries/TTGCAnalytics/libTTGCAnalytics.a'
      analy.vendored_framework = 'SDK/TTkGameSDK/Core/TTkGameSDK.framework'
      analy.dependency 'Firebase/Analytics'
      analy.dependency 'Firebase/DynamicLinks'
      analy.resources = 'SDK/TTkGameSDK/Core/TTkGame.bundle','SDK/TTkGameSDK/Core/TTGCProgressHUD.bundle'
  end

end
