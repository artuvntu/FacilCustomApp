#
# Be sure to run `pod lib lint FacilCustomApp.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'FacilCustomApp'
  s.version          = '0.0.2'
  s.summary          = 'Some clases and extensions useful for fast and easy creations apps.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
I continue working add more features and structure to this pod.
Some featues added by now are
 - Extension on UIView allow to you add anchors quickly
                       DESC

  s.homepage         = 'https://github.com/artuvntu/FacilCustomApp'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Arturo' => 'vardumotica@gmail.com' }
  s.source           = { :git => 'https://github.com/artuvntu/FacilCustomApp.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '15.5'
  s.swift_versions = "5"
  s.source_files = 'FacilCustomApp/Classes/**/*'
  
  # s.resource_bundles = {
  #   'FacilCustomApp' => ['FacilCustomApp/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
