# car2go_sample_swift

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

def available_pods
    pod 'Alamofire'
	pod 'AlamofireObjectMapper'
    pod 'SVPulsingAnnotationView'
end

target 'car2go_sample' do
    available_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.1'
        end
    end
end
