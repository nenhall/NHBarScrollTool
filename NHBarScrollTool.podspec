#
#  Be sure to run `pod spec lint NHBarScrollTool.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "NHBarScrollTool"
  s.version      = "1.1.1"
  s.summary      = "导航栏、工具栏一键跟随tableview的滚动来控制显示和隐藏"
  s.description  = <<-DESC
  导航栏、工具栏一键跟随tableview的滚动来控制显示和隐藏工具库
                   DESC
  s.homepage     = "https://github.com/neghao/NHBarScrollTool"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "nenhall" => "nenhall@126.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/neghao/NHBarScrollTool.git", :tag => "#{s.version}" }
  s.source_files = "NHBarScrollTool/*.{h,m}"
  s.requires_arc = true

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
   s.dependency "MJRefresh"
   s.dependency "NHExtension"


end
