Pod::Spec.new do |s|
  
  s.name         = "TestFlutter"
  s.version      = "1.0.2"
  s.summary      = "测试"

  s.description  = "测试"

  s.homepage     = "https://github.com/ApplePeels/TestAssets.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "测试" => "wangxingming@outlook.com" }
  s.source       = { :git => "https://github.com/ApplePeels/TestAssets.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.source_files = "Source/**/*.{h,m}"

  s.resource_bundles = {
    'TestFlutter' => ['TestFlutter.xcassets'],
  }

  s.preserve_paths = ['Resources/*']
  
end
