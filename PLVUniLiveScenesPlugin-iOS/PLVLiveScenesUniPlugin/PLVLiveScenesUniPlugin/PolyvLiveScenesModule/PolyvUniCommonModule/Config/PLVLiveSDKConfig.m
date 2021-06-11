//
//  PLVLiveSDKConfig.m
//  PolyvLiveScenesDemo
//
//  Created by ftao on 2020/6/12.
//  Copyright © 2020 polyv. All rights reserved.
//

#import "PLVLiveSDKConfig.h"

@interface PLVRoomViewUser ()

@property (nonatomic, copy) NSString *viewerId;
@property (nonatomic, copy) NSString *viewerName;
@property (nonatomic, copy) NSString *viewerAvatar;
@property (nonatomic, assign) NSUInteger viewerType;

@end

@implementation PLVRoomViewUser

+ (instancetype)viewUserWithUserId:(NSString *)viewerId
                        viewerName:(NSString *)viewerName
                      viewerAvatar:(NSString *)viewerAvatar
                        viewerType:(NSUInteger)viewerType {
    PLVRoomViewUser *user = [[PLVRoomViewUser alloc] init];
    user.viewerId = viewerId;
    user.viewerName = viewerName;
    user.viewerAvatar = viewerAvatar;
    user.viewerType = viewerType;
    return user;
}

@end

@interface PLVLiveSDKConfig ()

@end

@implementation PLVLiveSDKConfig

static PLVLiveSDKConfig *_sdkConfig = nil;

+ (instancetype)sharedSDK {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sdkConfig = [[super allocWithZone:NULL] init];
    });
    return _sdkConfig;
}

+ (void)configViewUserWithUserId:(NSString *)viewerId
                      viewerName:(NSString *)viewerName
                    viewerAvatar:(NSString *)viewerAvatar
                      viewerType:(NSUInteger)viewerType {
    PLVRoomViewUser *viewUser = [PLVRoomViewUser viewUserWithUserId:viewerId
                                                         viewerName:viewerName
                                                       viewerAvatar:viewerAvatar
                                                         viewerType:viewerType];
    [[self sharedSDK] setViewUser:viewUser];
}

@end
