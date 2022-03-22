## 1、 需求
我们要提供一个iOS 私有 SDK, 对方可以通过cocoapods安装, 并且只能看到头文件

##  2、大致流程
 - 使用Xcode创建一个framework工程, 在里面编写你需要提供的功能
 - 创建`podspec`文件, 依赖这个framework, 然后上传到`Cocoapods`.

## 3、具体流程
如果我们单独创建一个framework工程， 如果有需求修改每次都要导出framwork在demo工程中调试， 这就很麻烦，所以今天创建一个framework+demo的混合工程， 在一个工程中包含framework工程+demo工程+Pods工程。结构如下：
![在这里插入图片描述](https://img-blog.csdnimg.cn/e671773380534da5a1fabffd1948e8f7.png)
# 混和工程创建步骤
#### Step1: 创建Demo工程, 取名为MySDKDemo
- 创建完成加入Podfile文件, 并执行Pod install
```Java
platform :ios, '9.0'
target 'MySDKDemo' do
end
```

#### Step2: 创建framework工程, 取名为MySDK
![在这里插入图片描述](https://img-blog.csdnimg.cn/b9f7e12dd9a74284a755b2bf5569cb5a.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_20,color_FFFFFF,t_70,g_se,x_16)

### Step3:  关联项目
- 把创建好的MySDK移动到MySDKDemo下面
![在这里插入图片描述](https://img-blog.csdnimg.cn/c126711c729a45539c8c973466a67afa.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_20,color_FFFFFF,t_70,g_se,x_16)
- 然后把MySDK工程文件拖进项目
![在这里插入图片描述](https://img-blog.csdnimg.cn/ccebca1244f746b58632d52eced2abc2.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_20,color_FFFFFF,t_70,g_se,x_16)
- 拖入之后
![在这里插入图片描述](https://img-blog.csdnimg.cn/e282eb476bc343918e33a0157337d488.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_11,color_FFFFFF,t_70,g_se,x_16)
#### Step4: 配置Podfile
```Java
 platform :ios, '9.0'
 
#这里需要添加
workspace 'MySDKDemo.xcworkspace'

target 'MySDKDemo' do
    # Comment the next line if you don't want to use dynamic frameworks
    use_frameworks!
    # Demo工程依赖的第三方, 如果和SDK依赖的一致, 则Pod install的只会安装一份
    pod 'SVProgressHUD'
    pod 'AFNetworking'

end

target 'MySDK' do
    #需要添加SDK路径,
    project './MySDK/MySDK.xcodeproj'
    # MySDK依赖 SVProgressHUD 和 AFNetworking
    pod 'SVProgressHUD'
    pod 'AFNetworking'
end
```

- cd 到MySDKDemo路径下, 执行pod install
![在这里插入图片描述](https://img-blog.csdnimg.cn/28c56aa1b18142018081077297058488.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_20,color_FFFFFF,t_70,g_se,x_16)

![在这里插入图片描述](https://img-blog.csdnimg.cn/750554aab6c14fe0989422a97fbe83ac.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_11,color_FFFFFF,t_70,g_se,x_16)
- 当前选中demo工程进行调试
![在这里插入图片描述](https://img-blog.csdnimg.cn/b18de36b27d8460f82d610fdc167df2c.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_20,color_FFFFFF,t_70,g_se,x_16)
- 选中SDK, 进行编译
![在这里插入图片描述](https://img-blog.csdnimg.cn/46847c9328b741dcb0592bc6843b35d4.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_20,color_FFFFFF,t_70,g_se,x_16)

#### Step5: 联调
- 在demo中需要使用的时候，先在MySDK工程中command + B(确保demo中有效使用)
- demo中引入头文件#import <MySDK/MySDK.h>

# 以上工程架构搞定, 接下来开始改动MySDK工程, 进行测试
# MySDK工程中编写需求代码
- 在MySDK目录下创建一个Hud类进行测试
```Objc
#import "Hud.h"
#import <SVProgressHUD.h>
@implementation Hud
- (void)showToast:(NSString *)msg {
    [SVProgressHUD showInfoWithStatus:msg];
}
@end
```
- 拖进需要暴露的头文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/d53b7f2d8edc427586bf3b940b3a57f4.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_20,color_FFFFFF,t_70,g_se,x_16)
- ***在MySDK.h中引入你的Hud`#import <MySDK/Hud.h>`***
![在这里插入图片描述](https://img-blog.csdnimg.cn/46985f780fc34fa2be015f7085402f3d.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_20,color_FFFFFF,t_70,g_se,x_16)
- 在demo中使用
```Object
#import <MySDK/MySDK.h>

[Hud showToast:@"Hello"];
```

# 导出framework
![在这里插入图片描述](https://img-blog.csdnimg.cn/54416d79401e42aeaf4e478e20d788bd.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_13,color_FFFFFF,t_70,g_se,x_16)
![在这里插入图片描述](https://img-blog.csdnimg.cn/a4135833499c4eabbc185e65554a5150.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_20,color_FFFFFF,t_70,g_se,x_16)


# 发布到Cocoapods
- 创建MySDK.podspec文件, 并把导出的MySDK.framework一同放入同一个文件
![在这里插入图片描述](https://img-blog.csdnimg.cn/d4e266bb437040fcb59628abc5262213.png?x-oss-process=image/watermark,type_d3F5LXplbmhlaQ,shadow_50,text_Q1NETiBALS3po47otbfkupHmtowtLQ==,size_20,color_FFFFFF,t_70,g_se,x_16)
```
Pod::Spec.new do |s|
    s.name         = "MySDK"
    s.version      = "1.0.0"
    s.summary      = "测试用SDK"
    s.description  = <<-DESC
测试用SDK, 使用OC实现
    DESC
    s.homepage     = "https://github.com/nieyinlong/MySDK_iOS"
    s.author           = { 'nieyinlong' => 'nyl0819@126.com' }
    s.platform     = :ios, "9.0"
    s.source       = { :git => "https://github.com/nieyinlong/MySDK_iOS.git", :tag => s.version }
  # 过不支持真机调试则加上下面的
    s.pod_target_xcconfig = {
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  # 不支持真机结束
  
    s.vendored_frameworks = 'MySDK.framework'
    s.dependency 'AFNetworking', '~> 4.0'
    s.dependency 'SVProgressHUD'
end
```

- **执行发布命令**
- cd 到MySDK_iOS
```
pod lin lint --allow-warnings
pod tunk push
```
发布成功即可在其他项目中使用
```
pod 'MySDK'
```

#  报错解决'MySDK/MySDK.h' file not found
![在这里插入图片描述](https://img-blog.csdnimg.cn/a6515bacaa604ed88674da276e4fff5c.png)

