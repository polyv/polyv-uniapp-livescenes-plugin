# PLVUniLiveScenesPlugin-android
本项目是针对保利威多场景的uni-app客户提供的打包工程，用于打包 uni-app 项目（包含多场景插件）的自定义基座，也可用于打正式包。支持在该工程的基础上添加其他uni-app插件。

## 开发环境

uni-app 开发环境：HBuilderX 2.8.0+

Android 开发环境：JDK 1.8+， AndroidStudio 3.0+

## 前提条件

1. [保利威官网](http://www.polyv.net/)账号，需要在[保利威视频云平台](http://www.polyv.net/)注册账号，并开通相关服务。



## 集成打包说明

### 通用插件集成云打包

1. 购买插件，选择该插件绑定的项目。
2. 在HBuilderX里找到项目，在manifest的app原生插件配置中勾选模块，如需要填写参数则参考插件作者的文档添加。
3. 根据插件作者的提供的文档开发代码，在代码中引用插件，调用插件功能。
4. 打包[自定义基座](https://ask.dcloud.net.cn/article/35115)，选择插件，得到自定义基座，然后运行时选择自定义基座，进行log输出测试。
5. 开发完毕后正式云打包



## 引入 App 资源

每个 uni-app 项目都有自己的应用标识，可在配置文件 mainfest.json 中的【基础配置】里看到。关于 AppID 的更多信息，详见 [DCloud appid 用途/作用/使用说明](https://ask.dcloud.net.cn/article/35907)。

1. 生成本地打包 App 资源

   打开 HBuilderX 项目，选择【发行】-【原生App-本地打包】-【生成本地打包App资源】。

2. 拷贝 App 资源到插件工程

   将该文件夹拷贝到工程的 app/src/main/assets/apps 路径下，确保该路径名称为你的 AppID 文件夹

3. 修改 app/src/main/assets/data/dcloud_control.xml 里面 app 节点的 appid 属性为你的 AppID。

## 

## SDK 集成

为避免SDK更新导致的插件兼容问题，开发者应当根据集成的版本下载Android 离线SDK：https://nativesupport.dcloud.net.cn/AppDocs/download/android。

然后按照[官方文档](https://nativesupport.dcloud.net.cn/AppDocs/usesdk/android?id=%e9%85%8d%e7%bd%ae%e5%b7%a5%e7%a8%8b)，更新 app/libs 下的对应sdk文件。



### Android 离线打包集成

由于 uni-app 的云端打包限制了每日免费打包的次数以及免费打包的包体的大小（超过40M每次打包需充值付费），使用离线打包的方式会更加自由、方便。

#### 自定义基座

点击菜单栏【Build】-【Build Bundle(s) / APK(s)】-【Build Apk(s)】，将会在app/build/outputs/apk/debug 下生成 android_debug.apk 文件，这个就是自定义基座。

将生成的 android_debug.apk 文件放到 HBuilderX 项目下的 unpackage/debug 路径下，选择 HBuilderX 菜单栏【运行】-【运行到手机或模拟器】-【运行基座选择】-【自定义基座】。然后运行到对应的Android设备即可。



#### 正式包

打开 app/build.gradle，修改【versionCode】和【versionName】为需要的版本号。

选择【Build】-【Generate Signed Bundle / APK...】，在弹窗中选择【APK】，点击 Next。

选择签名证书文件，如果没有请新建【Create New...】，按实际情况填写构建证书，相关信息和文件请保存下来，下一次打包迭代发版时也会用到。（如果证书不同，将会导致应用无法直接升级安装，需要卸载安装。）

按创建证书时填写的信息，输入Key的相关信息，点击Next，选择【release】，并将弹窗下方【Signature Version】一起勾选 V1 和 V2。点击Finish，将会生成正式包，位于 app/release/下。



### 项目配置

关于如何对 app 进行个性化配置，譬如 app 图标、app 名称、app 版本号、app 启动图等，uni-app 官方有详细的文档指导，见：[Android 原生工程配置](https://nativesupport.dcloud.net.cn/AppDocs/usesdk/android)。

该项目还支持添加其他 uni-app 原生插件，添加方法详见 uni-app 官方的指引文档 [Android 离线打包使用插件](https://nativesupport.dcloud.net.cn/NativePlugin/offline_package/android)。
