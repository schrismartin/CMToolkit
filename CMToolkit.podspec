#
# Be sure to run `pod lib lint CMToolkit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CMToolkit'
  s.version          = '1.0.1'
  s.summary          = 'A collection of tools, utilities, and helpers augmenting the Swift standard library.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'This framework acts as an augmentation of the swift standard library, adding common shorthands and convenience utilities to make life just that much better. Because you deserve nice things.'
  s.homepage         = 'https://github.com/schrismartin/CMToolkit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Chris Martin' => 'schrismartin@me.com' }
  s.source           = { :git => 'https://github.com/schrismartin/CMToolkit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/schrismartin'
  s.swift_version    = '5.0'
  s.ios.deployment_target = '9.0'

  s.source_files = 'Sources/**/*'
  
  # s.resource_bundles = {
  #   'CMToolkit' => ['CMToolkit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
