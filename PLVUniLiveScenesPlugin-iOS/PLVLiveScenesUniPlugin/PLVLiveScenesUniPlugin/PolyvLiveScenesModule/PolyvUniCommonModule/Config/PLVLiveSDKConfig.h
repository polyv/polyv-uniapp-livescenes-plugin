//
//  PLVLiveSDKConfig.h
//  PolyvLiveScenesDemo
//
//  Created by ftao on 2020/6/12.
//  Copyright © 2020 polyv. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 直播间用户
@interface PLVRoomViewUser : NSObject

/// 用户唯一标识，用于登录socket、发送日志
@property (nonatomic, copy, readonly) NSString *viewerId;

/// 用户昵称，用于登录socket、发送日志
@property (nonatomic, copy, readonly) NSString *viewerName;

/// 用户头像地址，用于登陆socket
@property (nonatomic, copy, readonly) NSString *viewerAvatar;

/// 用户类型/角色，用于登陆socket
@property (nonatomic, assign, readonly) NSUInteger viewerType;

/// 初始化方法3
/// @param viewerId 用户ID
/// @param viewerName 用户昵称
/// @param viewerAvatar 用户头像
/// @param viewerType 用户类型
+ (instancetype)viewUserWithUserId:(NSString * _Nullable)viewerId
                        viewerName:(NSString * _Nullable)viewerName
                      viewerAvatar:(NSString * _Nullable)viewerAvatar
                        viewerType:(NSUInteger)viewerType;

@end

/// 直播SDK配置信息
@interface PLVLiveSDKConfig : NSObject

/// 直播间用户
@property (nonatomic, strong) PLVRoomViewUser *viewUser;
/// 自定义跑马灯Code
@property (nonatomic, copy) NSString *marqueeCode;

/// 单例方法
+ (instancetype)sharedSDK;

/// 配置直播间用户信息
+ (void)configViewUserWithUserId:(NSString * _Nullable)viewerId
                      viewerName:(NSString * _Nullable)viewerName
                    viewerAvatar:(NSString * _Nullable)viewerAvatar
                      viewerType:(NSUInteger)viewerType;
@end

NS_ASSUME_NONNULL_END
