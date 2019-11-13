use_frameworks!
podspec :path => 'PCFSwift.podspec'
platform :ios, '10.0'

def shared_pods
	pod 'PCFSwift', :path => './'
	pod 'PCFSwift/Alamofire', :path => './'
	pod 'PCFSwift/TouchID', :path => './'
	pod 'PCFSwift/Wishlist', :path => './'
	pod 'PCFSwift/1Password', :path => './'
	pod 'PCFSwift/EnvironmentSwitcher', :path => './'
	pod 'PCFSwift/KeychainManager', :path => './'
	pod 'PCFSwift/KillSwitch', :path => './'
	pod 'SwiftLint', '0.22.0'
end

target 'PCFSwift' do
	shared_pods
end

target 'PCFSwift_Tests' do
	shared_pods
end
