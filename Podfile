# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def common_pods
  pod 'PinLayout', '~> 1.8.7'
  pod 'Kingfisher', '~> 5.7.1'
  pod 'SegementSlide', '~> 2.2.1'
  
  # Google API
  pod 'Fabric', '~> 1.10.2'
  pod 'Crashlytics', '~> 3.14.0'
  pod 'Firebase/Analytics'
end


target 'HabitTracker' do
  use_frameworks!

  common_pods
end

target 'HabitTrackerTests' do
  inherit! :search_paths
  # Pods for testing
end

target 'HabitTrackerUITests' do
  # Pods for testing
end
