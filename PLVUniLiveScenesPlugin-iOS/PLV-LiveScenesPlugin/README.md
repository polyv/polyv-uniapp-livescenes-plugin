# Polyv多场景uni 插件

## 简介

该插件封装了保利威 Android 与 iOS 原生多场景 Demo SDK。使用本模块可以轻松把保利威 Android 与 iOS 多场景功能集成到自己的 App 中。目前主要集成了云课堂场景和直播带货场景。

- 云课堂场景：

  实现保利威视频教学直播、ppt 在线演示同步播放、教学连麦、在线聊天功能，以及直播回放功能。

- 直播带货场景：

  实现视频直播、在线聊天、打赏、商品等功能，非常适合直播带货的应用场景。

## 注意事项

* **请务必通过 ConfigModule 的 setViewerInfo 设置观众ID，观众ID是后台区分用户的唯一标识别。**

* **如果云打包遇到问题可以移步到离线工程插件工程，进行离线打包。**
  
  * iOS离线工程 [uniapp-livescenes-ios](https://github.com/polyv/polyv-uniapp-livescenes-plugin) ；
  * android离线工程[uniapp-livescenes-android](https://github.com/polyv/polyv-uniapp-livescenes-plugin)
  
* **Android端需要同时集成[Polyv播放器插件-Android ](https://ext.dcloud.net.cn/plugin?id=4798)和 [Polyv弹幕库插件-Android](https://ext.dcloud.net.cn/plugin?id=4947)，如果[Polyv播放器插件-Android ](https://ext.dcloud.net.cn/plugin?id=4798)和VideoPlayer同时集成，就要去掉弹幕库**；

  ```
  .方案一
  ├── Polyv多场景插件
  ├── Polyv弹幕库插件-Android
  └── Polyv播放器插件-Android
  .方案二
  ├── Polyv多场景插件
  ├── VideoPlayer插件
  └── Polyv播放器插件-Android
  ```

* **iOS 端自0.1.0+需要同时集成 [Polyv UTDID 插件-iOS](https://ext.dcloud.net.cn/plugin?id=7750)。如果本插件同时集成了 支付模块的支付宝支付 则不需要集成 [Polyv UTDID 插件-iOS] 插件**

* **为防止APP端被嗅探和反编译到开发者配置信息，强烈建议开发者设计自己的加密方式在服务端对 `userId`、 `AppID`、 `AppSecret`进行加密，并通过https协议的接口获取后重新解密，再将参数传递给SDK。**


## 快速使用

### 1. [保利威视频云平台](https://www.polyv.net/?f=dcloud_uniapp-211019)注册账号，并开通相关服务

### 2. 下载示例项目[uniapp-livescenes-demo](https://ext.dcloud.net.cn/plugin?id=5307)

### 3. 【仅限测试！】使用保利威视频云平台配置的的appId、userId、appSecret替换项目中的对应配置，实际场景请务必进行加密处理。

### 4. 集成【Polyv多场景uni 插件】，打包成对应平台的自定义基座体验项目

### 5. API说明

#### 引入插件

```
var playModule = uni.requireNativePlugin("PLV-LiveScenesPlugin-PlayModule")
var configModule = uni.requireNativePlugin("PLV-LiveScenesPlugin-ConfigModule")	
```

#### 配置模块 - ConfigModule

ConfigModule 封装了账号信息、用户信息、SDK配置功能。
开发者要播放保利威视频，需先到 [保利威官网](https://www.polyv.net/?f=dcloud_uniapp-211019) 注册账号，登录账号后，进入**云直播 - 开发设置** 获取 `userId`、 `AppID`、 `AppSecret`，并将加密得到加密串放到自己的服务器，再在移动端通过网络获取加密串，app 本地解密，并设置给 `setConfig` 方法。配置模块信息如果没有特殊说明都需要在进入直播间前配置。

###### 1. setViewerInfo

配置直播间用户信息。（直播间用户的属性在初始化后不允许修改）
方法：`setViewerInfo()`

示例：

```vue
configModule.setViewerInfo({
	viewerId:"",
	viewerName: "",
	viewerAvatar: "",
}, (result) => {
})
```

**参数：**

| 名称                | 类型                                       | 说明                                         |
| :------------------ | :----------------------------------------- | :------------------------------------------- |
| params.viewerId     | String                                     | 对应观看日志中的 用户ID                      |
| params.viewerName   | String                                     | 对应观看日志中的 用户昵称                    |
| params.viewerAvatar | String                                     | 观看用户的头像                               |
| callback            | function `{"isSuccess": 0, @"errMsg": ""}` | 执行结果的callback，返回是否成功的状态和描述 |

###### 2. setConfig

设置多场景的账号属性。**为防止APP端被嗅探和反编译到开发者配置信息，强烈建议开发者设计自己的加密方式在服务端对 `userId`、 `AppID`、 `AppSecret`进行加密，并通过https协议的接口获取后重新解密，再将参数传递给SDK。**
方法：`setConfig()`

示例：

```
configModule.setConfig({
	appId: "",
	userId: "",
	appSecret: ""
}, (result) => {
});
```

**参数：**

| 名称                     | 类型                                       | 说明                                         |
| :----------------------- | :----------------------------------------- | :------------------------------------------- |
| params.appId `(必需)`    | String                                     | polyv 云直播应用ID （可在云直播后台插件）    |
| params.userId`(必需)`    | String                                     | polyv 云直播账号ID                           |
| params.appSecret`(必需)` | String                                     | 用户头像地址polyv 云直播应用密匙             |
| callback                 | function `{"isSuccess": 0, @"errMsg": ""}` | 执行结果的callback，返回是否成功的状态和描述 |

###### 3. setMarqueeConfig

设置自定义跑马灯的配置属性
方法：`setMarqueeConfig()`

示例

```
configModule.setMarqueeConfig({
		code: "",
}, (result) => {
})
```

**参数：**

| 名称        | 类型                                       | 说明                                         |
| :---------- | :----------------------------------------- | :------------------------------------------- |
| params.code | String                                     | 跑马灯code参数配置                           |
| callback    | function `{"isSuccess": 0, @"errMsg": ""}` | 执行结果的callback，返回是否成功的状态和描述 |



#### 播放模块 - PlayConfig

playModule 封装了云课堂、直播带货的直播和回放功能。

###### 3. loginLiveRoom

直播登录（云课堂场景，带货直播场景登录）

方法：`loginLiveRoom()`

示例：

```vue
// 直播
playModule.loginLiveRoom(1, {
	channelId: ""
}, (result) => {
});
```

**参数：**

| 名称                     | 类型                                       | 说明                                         |
| :----------------------- | :----------------------------------------- | :------------------------------------------- |
| sceneType `(必需)`       | Number(1云课堂场景, 2直播带货场景)         | 直播室类型                                   |
| params.channelId`(必需)` | String                                     | 直播的频道号                                 |
| callback                 | function `{"isSuccess": 0, @"errMsg": ""}` | 执行结果的callback，返回是否成功的状态和描述 |

###### 4. loginPlaybackRoom

登录回放直播间（云课堂，带货直播回放登录）

方法：`loginPlaybackRoom()`

示例：

```
playModule.loginPlaybackRoom(0, {
	channlId: "",
	videoId: "",
	vodType: 0
}, (result) => {
});
```

**参数：**

| 名称                     | 类型                                       | 说明                                         |
| :----------------------- | :----------------------------------------- | :------------------------------------------- |
| sceneType `(必需)`       | Number(1云课堂场景, 2直播带货场景)         | 直播室类型                                   |
| params.channelId`(必需)` | String                                     | 直播的频道号                                 |
| params.videoId`(必需)`   | String                                     | 回放视频id                                   |
| params.vodType`(必需)`   | Number 0回放视频 1回放列表                 |                                              |
| callback                 | function `{"isSuccess": 0, @"errMsg": ""}` | 执行结果的callback，返回是否成功的状态和描述 |