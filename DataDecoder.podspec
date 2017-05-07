#
# Be sure to run `pod lib lint DataDecoder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DataDecoder'
  s.version          = '0.6.1'
  s.summary          = 'Swift Data Decoder. Easily Decode Data values'

  s.description      = <<-DESC
Swift Data Decoder. Easily Decode Data values.
                       DESC

  s.homepage         = 'https://github.com/FitnessKit/DataDecoder'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kevin A. Hoogheem' => 'kevin@hoogheem.net' }
  s.source           = { :git => 'https://github.com/FitnessKit/DataDecoder.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/**/*'

end
