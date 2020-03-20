# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'Lemi' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Lemi
  pod 'Alamofire',              '4.8.2'
  pod 'AlamofireObjectMapper',  '5.2.0'
  
  pod 'RxSwift',                '4.4.0'
  pod 'RxCocoa',                '4.4.0'
  pod 'RxAtomic',               '4.4.0'
  pod 'RxDataSources',          '3.1.0'
  pod 'SDWebImage',             '4.4.8'
  
  # Specify specific Swift Version per dependency
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '4.2'
          end
      end
  end
end
