 platform :ios, '9.0'
 
#这里需要添加
workspace 'MySDKDemo.xcworkspace'

target 'MySDKDemo' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!
    # Demo工程依赖的第三方, 如果和SDK依赖的一致, 则Pod install的只会安装一份
#    pod 'SVProgressHUD'
#    pod 'AFNetworking'

end

target 'MySDK' do
    #需要添加SDK路径,
    project './MySDK/MySDK.xcodeproj'
    # MySDK依赖 SVProgressHUD 和 AFNetworking
    pod 'SVProgressHUD'
    pod 'AFNetworking'
end

