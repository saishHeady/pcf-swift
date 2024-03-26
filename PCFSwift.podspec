#
# Be sure to run `pod lib lint PCFSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
# For a tutorial on how to build Podspec for PCF, http://www.dbotha.com/2014/12/04/optional-cocoapod-dependencies/
#

Pod::Spec.new do |s|
  s.name             = "PCFSwift"
  s.version          = "5.0.0"
  s.summary          = "An iOS library for easy integration with Prolific eCommerce Framework"

  s.description      = <<-DESC
This framework provides protocols and structs to support developers with the implementation of an eCommerce app when using the Prolific eCommerce Framework on the server side.
                       DESC

  s.homepage         = "https://bitbucket.org/prolificinteractive/pcf-swift"
  s.license          = 'MIT'
  s.author           = { "Prolific Interactive" => "info@prolificinteractive.com" }
  s.source           = { :git => "git@bitbucket.org:prolificinteractive/pcf-swift.git", :tag => s.version.to_s }

  s.default_subspec = 'Core'
  s.ios.deployment_target = '14.0'

  s.subspec 'Core' do |core|
    core.source_files = 'PCFSwift/Sources/Core/**/*'
  end

  s.subspec '1Password' do |onepassword|
    onepassword.source_files = 'PCFSwift/Sources/1Password/**/*'
    onepassword.dependency '1PasswordExtension', '~> 1.8'
    onepassword.dependency 'PCFSwift/Core'
  end

  s.subspec 'AddressGeocoder' do |geocoder|
    geocoder.dependency 'AddressGeocoder'
  end

  s.subspec 'Alamofire' do |alamofire|
    alamofire.source_files = 'PCFSwift/Sources/Alamofire/**/*'
    alamofire.dependency 'Alamofire', '5.9.0'
    alamofire.dependency 'PCFSwift/Core'
  end

  s.subspec 'EnvironmentSwitcher' do |switcher|
    switcher.source_files = 'PCFSwift/Sources/EnvironmentSwitcher/**/*'
    switcher.dependency 'PCFSwift/Core'
#    switcher.dependency 'Yoshi/QAKit'
  end

  s.subspec 'GenericValidator' do |validator|
    validator.dependency 'GenericValidator'
  end

  s.subspec 'KeychainManager' do |keychainManager|
    keychainManager.source_files = 'PCFSwift/Sources/KeychainManager/**/*'
    keychainManager.dependency 'PCFSwift/Core'
    keychainManager.dependency 'KeychainAccess', '4.2.2'
  end

  s.subspec 'KillSwitch' do |killswitch|
    killswitch.source_files = 'PCFSwift/Sources/KillSwitch/**/*'
    killswitch.dependency 'Siren', '6.1.2'
    killswitch.dependency 'PCFSwift/Core'
    killswitch.dependency 'Bellerophon'
  end

  s.subspec 'TouchID' do |touchid|
    touchid.source_files = 'PCFSwift/Sources/TouchID/**/*'
  end

  s.subspec 'Wishlist' do |wishlist|
    wishlist.source_files = 'PCFSwift/Sources/Wishlist/**/*'
    wishlist.dependency 'PCFSwift/Core'
  end
end
