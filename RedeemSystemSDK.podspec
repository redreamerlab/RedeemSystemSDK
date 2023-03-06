#
# Be sure to run `pod lib lint RedeemSystemSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RedeemSystemSDK'
  s.version          = '1.0.0'
  s.summary          = 'RE:DREAMER Lab Redeem System SDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Redeem System SDK is a Swift library to intergate with RE:DREAMER Lab's Redeem System.
                       DESC

  s.homepage         = 'https://github.com/redreamerlab/RedeemSystemSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RE:DREAMER Lab' => 'dev@redreamer.io' }
  s.source           = { :git => 'https://github.com/redreamerlab/RedeemSystemSDK.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/REDREAMER_Lab'

  s.ios.deployment_target = '13.0'

  s.source_files = 'RedeemSystemSDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RedeemSystemSDK' => ['RedeemSystemSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
