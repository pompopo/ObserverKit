#
# Be sure to run `pod spec lint ObserverKit.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "ObserverKit"
  s.version      = "1.1.0"
  s.summary      = "Simple library for UIControl, NSNotification, Key Value Observing."
  s.homepage     = "https://github.com/pompopo/ObserverKit"
  s.license      = 'MIT'
  s.author       = { "pompopo" => "pompopo@gmail.com" }
  s.source       = { :git => "https://github.com/pompopo/ObserverKit.git", :tag => "1.1.0" }
  s.platform     = :ios, '7.0'

  s.source_files = 'ObserverKit', 'ObserverKit/*.{h,m}'
  s.exclude_files = 'ObserverKitDemo'
  s.requires_arc = true
end
