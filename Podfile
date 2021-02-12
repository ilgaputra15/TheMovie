# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!
 
workspace 'TheMovie'

def shared
    use_frameworks!
    pod 'RealmSwift'
end

target 'TheMovie' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SwiftLint'
  pod 'RxCocoa', '5.1.1'
  pod 'Moya/RxSwift', '~> 14.0'
  pod 'RealmSwift'
  
  # Pods for TheMovie
end

target 'Core' do
  project 'Core/Core.project'
  use_frameworks!
  pod 'RxCocoa', '5.1.1'
  pod 'Moya/RxSwift', '~> 14.0'
end

target 'Home' do
  project 'Home/Home.project'
  use_frameworks!
  pod 'RxCocoa', '5.1.1'
  pod 'Moya/RxSwift', '~> 14.0'
end

target 'MovieSearch' do
  project 'MovieSearch/MovieSearch.project'
  use_frameworks!
  pod 'RxCocoa', '5.1.1'
  pod 'Moya/RxSwift', '~> 14.0'
end

target 'MovieDetail' do
  project 'MovieDetail/MovieDetail.project'
  use_frameworks! 
  pod 'RxCocoa', '5.1.1'
  pod 'Moya/RxSwift', '~> 14.0'
  pod 'RealmSwift'
end

