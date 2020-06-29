#
# Be sure to run `pod lib lint ZLiOSKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZLiOSKit'
  s.version          = '1.0.0'
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
  s.subspec 'Tools' do |tools|
    # LocationTool
    tools.subspec 'LocationTool' do |locationTool|
        locationTool.source_files = 'ZLiOSKit/Tools/LocationTool/**/*'
    end
    # TimeTool
    tools.subspec 'TimeTool' do |timeTool|
        timeTool.source_files = 'ZLiOSKit/Tools/TimeTool/**/*'
    end
    # ViewControllerTool
    tools.subspec 'ViewControllerTool' do |viewControllerTool|
        viewControllerTool.source_files = 'ZLiOSKit/Tools/ViewControllerTool/**/*'
    end
    # DigitTool
    tools.subspec 'DigitTool' do |digitTool|
        digitTool.source_files = 'ZLiOSKit/Tools/DigitTool/**/*'
        digitTool.dependency 'ZLiOSKit/Theme'
    end
  end
  
  
  s.subspec 'Components' do |components|
    # ViewModels
    components.subspec 'ViewModels' do |viewModels|
        viewModels.source_files = 'ZLiOSKit/Components/ViewModels/**/*'
        viewModels.dependency 'ZLiOSKit/Tools/TimeTool'
    end
    # ActionSheet
    components.subspec 'ActionSheet' do |actionSheet|
        actionSheet.source_files = 'ZLiOSKit/Components/ActionSheet/**/*'
    end
    # Buttons
    components.subspec 'Buttons' do |buttons|
        buttons.source_files = 'ZLiOSKit/Components/Buttons/**/*'
    end
    # Alerts
    components.subspec 'Alerts' do |alerts|
        alerts.source_files = 'ZLiOSKit/Components/Alerts/**/*'
        alerts.dependency 'TTTAttributedLabel', '~> 2.0.0'
    end
    # Navigation
    components.subspec 'Navigation' do |navigation|
        navigation.source_files = 'ZLiOSKit/Components/Navigation/**/*'
        navigation.dependency 'ZLiOSKit/Components/Alerts'
    end
    # EmotionMap
    components.subspec 'EmotionMap' do |emotionMap|
        emotionMap.source_files = 'ZLiOSKit/Components/EmotionMap/**/*'
    end
    # Tables
    components.subspec 'Tables' do |tables|
        tables.source_files = 'ZLiOSKit/Components/Tables/**/*'
        tables.dependency 'ZLiOSKit/Components/EmotionMap'
        tables.dependency 'MJRefresh', '~> 3.4.3'
    end
    # TableCells
    components.subspec 'TableCells' do |tableCells|
        tableCells.source_files = 'ZLiOSKit/Components/TableCells/**/*'
        tableCells.dependency 'ZLiOSKit/Components/Tables'
    end
    # ZKCycleScrollView
    components.subspec 'ZKCycleScrollView' do |zkCycleScrollView|
        zkCycleScrollView.source_files = 'ZLiOSKit/Components/ZKCycleScrollView/**/*'
    end
    # Banners
    components.subspec 'Banners' do |banners|
        banners.source_files = 'ZLiOSKit/Components/Banners/*.{h,m}'
        banners.dependency 'ZLiOSKit/Components/ZKCycleScrollView'
        banners.dependency 'ZLiOSKit/Components/Tables'
        banners.dependency 'ZLiOSKit/Components/ViewModels'
        banners.subspec 'Styles' do |styles|
            styles.source_files = 'ZLiOSKit/Components/Banners/Styles/**/*'
        end
    end
    # Menus
    components.subspec 'Menus' do |menus|
        menus.source_files = 'ZLiOSKit/Components/Menus/**/*'
        menus.dependency 'ZLiOSKit/Components/Tables'
    end
    # DigitLabel
    components.subspec 'DigitLabel' do |digitLabel|
        digitLabel.source_files = 'ZLiOSKit/Components/DigitLabel/**/*'
        digitLabel.dependency 'ZLiOSKit/Tools/DigitTool'
    end
    # GroupHeaders
    components.subspec 'GroupHeaders' do |groupHeaders|
        groupHeaders.source_files = 'ZLiOSKit/Components/GroupHeaders/**/*'
    end
    # Tags
    components.subspec 'Tags' do |tags|
        tags.source_files = 'ZLiOSKit/Components/Tags/**/*'
        tags.dependency 'ZLiOSKit/Categories'
    end
    # News
    components.subspec 'News' do |news|
        news.subspec 'ZX01' do |zx01|
            zx01.source_files = 'ZLiOSKit/Components/News/ZX01/**/*'
            zx01.dependency 'ZLiOSKit/Components/Tags'
        end
        news.subspec 'ZX02' do |zx02|
            zx02.source_files = 'ZLiOSKit/Components/News/ZX02/**/*'
        end
        news.dependency 'ZLiOSKit/Components/Tables'
        news.dependency 'ZLiOSKit/Components/ViewModels'
    end
    # Links
    components.subspec 'Links' do |links|
        links.source_files = 'ZLiOSKit/Components/Links/**/*'
    end
    # Notifications
    components.subspec 'Notifications' do |notifications|
        notifications.subspec 'TZ01' do |tz01|
            tz01.source_files = 'ZLiOSKit/Components/Notifications/TZ01/**/*'
        end
        notifications.dependency 'ZLiOSKit/Components/Tables'
        notifications.dependency 'ZLiOSKit/Components/ViewModels'
    end
    # Picker
#    components.subspec 'Picker' do |picker|
#        picker.source_files = 'ZLiOSKit/Components/Picker/*.{h,m}'
#        picker.dependency 'STPickerView', '~> 2.4'
#        picker.dependency 'ZLiOSKit/Categories'
#    end
    
    
    components.dependency 'Masonry', '~> 1.1.0'
    components.dependency 'ZLiOSKit/Theme'
  end
  
  
  # s.resource_bundles = {
  #   'ZLiOSKit' => ['ZLiOSKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '~> 2.3'
   
end
