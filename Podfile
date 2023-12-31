# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'


target 'ulearning_app_ios' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ulearning_app_ios
  pod 'Alamofire', '= 5.0.0-rc.2'
  pod 'AlamofireObjectMapper'
  pod 'SwiftyJSON'
  pod 'ObjectMapper'
  pod 'GoogleSignIn'
  pod 'Keyboardy'
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
