//
//  PLVLiveScenesConfigModule.m
//  PLVLiveScenesUniPlugin
//
//  Created by Sakya on 2021/5/8.
//

#import "PLVLiveScenesConfigModule.h"
#import <PLVLiveScenesSDK/PLVLiveScenesSDK.h>
#import "PLVLiveScenesUtils.h"
#import "PLVLiveSDKConfig.h"

@implementation PLVLiveScenesConfigModule

/**
 设置多场景的账号属性
 */
WX_EXPORT_METHOD(@selector(setConfig:callback:))

-(void)setConfig:(NSDictionary*)options
        callback:(WXModuleKeepAliveCallback)callback {

    NSString *appId = [PLVLiveScenesUtils stringValueWithDictionary:options forKey:@"appId" defaultValue:nil];
    NSString *appSecret = [PLVLiveScenesUtils stringValueWithDictionary:options forKey:@"appSecret" defaultValue:nil];
    NSString *userId = [PLVLiveScenesUtils stringValueWithDictionary:options forKey:@"userId" defaultValue:nil];
    
    //判空
    if(![PLVLiveScenesUtils isValidString:appId]) {
        [self callbackResultOnce:callback isSucceed:NO errMsg:@"appId 不能为空"];
        return;
    }
    if(![PLVLiveScenesUtils isValidString:appSecret]) {
        [self callbackResultOnce:callback isSucceed:NO errMsg:@"appSecret 不能为空"];
        return;
    }
    if(![PLVLiveScenesUtils isValidString:userId]) {
        [self callbackResultOnce:callback isSucceed:NO errMsg:@"userId 不能为空"];
        return;
    }
    //配置账号信息
    PLVLiveVideoConfig *liveConfig = [PLVLiveVideoConfig sharedInstance];
    BOOL result = [liveConfig configWithUserId:userId appId:appId appSecret:appSecret];
    [self callbackResultOnce:callback isSucceed:result errMsg:@""];
}

/**
 配置直播间用户信息
 */
WX_EXPORT_METHOD(@selector(setViewerInfo:callback:))

-(void)setViewerInfo:(NSDictionary*)options
            callback:(WXModuleKeepAliveCallback)callback {
    
    //判空
    NSString *viewerId = [PLVLiveScenesUtils stringValueWithDictionary:options forKey:@"viewerId" defaultValue:nil];
    if(![PLVLiveScenesUtils isValidString:viewerId]) {
        [self callbackResultOnce:callback isSucceed:NO errMsg:@"viewerId 不能为空"];
        return;
    }
    
    NSString *viewerName = [PLVLiveScenesUtils stringValueWithDictionary:options forKey:@"viewerName" defaultValue:nil];
    if(![PLVLiveScenesUtils isValidString:viewerName]) {
        [self callbackResultOnce:callback isSucceed:NO errMsg:@"optViewerName 不能为空"];
        return;
    }
    
    NSString *viewerAvatar = [PLVLiveScenesUtils stringValueWithDictionary:options forKey:@"viewerAvatar" defaultValue:nil];
    if(![PLVLiveScenesUtils isValidString:viewerAvatar]) { //默认头像
        viewerAvatar = @"https://s1.videocc.net/face.png";
    }

    [PLVLiveSDKConfig configViewUserWithUserId:viewerId
                                    viewerName:viewerName
                                  viewerAvatar:viewerAvatar
                                    viewerType:0];
    [self callbackResultOnce:callback isSucceed:YES errMsg:@""];
}

/**
 配置跑马灯Code
 */
WX_EXPORT_METHOD(@selector(setMarqueeConfig:callback:))

-(void)setMarqueeConfig:(NSDictionary*)options
               callback:(WXModuleKeepAliveCallback)callback {
    NSString *marqueeCode = PLV_SafeStringForDictKey(options, @"code");
    if (!PLV_SafeStringForValue(marqueeCode)) {
        [self callbackResultOnce:callback isSucceed:NO errMsg:@"跑马灯参数异常"];
        return;
    }
    [PLVLiveSDKConfig sharedSDK].marqueeCode = marqueeCode;
    [self callbackResultOnce:callback isSucceed:YES errMsg:@"跑马灯参数配置成功"];
}


-(void)callbackResultOnce:(WXModuleKeepAliveCallback)callback
                isSucceed:(BOOL)isSucceed
                   errMsg:(NSString*)errMsg {
    if(callback){
        callback(@{@"isSuccess": @(isSucceed), @"errMsg": errMsg}, NO);
    }
}

@end
