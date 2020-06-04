#
# Be sure to run `pod lib lint ZLiOSKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZLiOSKit'
  s.version          = '0.1.0'
  s.summary          = 'ZL iOS基础库'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/yezixcc/ZLiOSKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gaoxingwang' => '794575986@qq.com' }
  # 基础库代码远程仓库（上面建好的仓库）
  s.source           = { :git => 'https://github.com/yezixcc/ZLiOSKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  
  # 基础库代码路径，如果ZLiOSKit文件夹下没有.h，.m文件就不要写这个路径，否则影响文件夹分类
#  s.source_files = 'ZLiOSKit/Classes/**/*'
  
  # 文件夹分类-注意内部依赖顺序
  # 1.首先写不依赖任何其他的文件夹
  s.subspec 'Categories' do |categories|
    categories.source_files = 'ZLiOSKit/Categories/**/*'
  end
  
  # 2.依赖Categories，所以Categories要写在前面
  s.subspec 'Theme' do |theme|
    theme.source_files = 'ZLiOSKit/Theme/**/*'
    theme.dependency 'ZLiOSKit/Categories'
  end
  
  # 3.依赖Theme，所以Theme要写在前面
  s.subspec 'Components' do |components|
    components.subspec 'ActionSheet' do |actionSheet|
        actionSheet.source_files = 'ZLiOSKit/Components/ActionSheet/**/*'
    end
    components.subspec 'Buttons' do |buttons|
        buttons.source_files = 'ZLiOSKit/Components/Buttons/**/*'
    end
    components.dependency 'Masonry', '~> 1.1.0'
    components.dependency 'ZLiOSKit/Theme'
  end
  
  # s.resource_bundles = {
  #   'ZLiOSKit' => ['ZLiOSKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
