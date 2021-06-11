//
//  PLVLiveScenesPlayModule.m
//  PLVLiveScenesUniPlugin
//
//  Created by Sakya on 2021/5/8.
//

#import "PLVLiveScenesPlayModule.h"
#import <PolyvFoundationSDK/PLVProgressHUD.h>
#import "PLVRoomLoginClient.h"
#import "PLVRoomDataManager.h"

#import "PLVLiveSDKConfig.h"
#import "PLVLCCloudClassViewController.h"
#import "PLVECWatchRoomViewController.h"
#import "PLVBugReporter.h"
#import "PLVLiveScenesUtils.h"

@implementation PLVLiveScenesPlayModule

#define OpenBugly 0

WX_EXPORT_METHOD(@selector(loginLiveRoom:options:callback:))

- (void)loginLiveRoom:(NSInteger)sceneType
              options:(NSDictionary *)options
             callback:(WXModuleKeepAliveCallback)callback {
    NSString *channelId = [PLVLiveScenesUtils stringValueWithDictionary:options forKey:@"channelId" defaultValue:nil];
    //判空
    if(![PLVLiveScenesUtils isValidString:channelId]){
        [self callbackResultOnce:callback isSucceed:NO errMsg:@"channelId 不能为空"];
        return;
    }
    
    PLVProgressHUD *hud = [PLVProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [hud.label setText:@"登录中..."];
    //判断场景
    PLVChannelType channelType = sceneType == 1 ? PLVChannelTypePPT | PLVChannelTypeAlone : PLVChannelTypeAlone;
    PLVLiveVideoConfig *videoConfig = [PLVLiveVideoConfig sharedInstance];
    __weak typeof(self) weakSelf = self;
    [PLVRoomLoginClient loginLiveRoomWithChannelType:channelType
                                           channelId:channelId
                                              userId:videoConfig.userId
                                               appId:videoConfig.appId
                                           appSecret:videoConfig.appSecret
                                            roomUser:^(PLVRoomUser * _Nonnull roomUser) {
        //      可在此处配置自定义的登陆用户ID、昵称、头像，不配则均使用默认值
        //      PLVRoomViewUser *viewUser = [PLVLiveSDKConfig sharedSDK].viewUser;
        //      roomUser.viewerId = viewUser.viewerId;
        //      roomUser.viewerName = viewUser.viewerName;
        //      roomUser.viewerAvatar = viewUser.viewerAvatar;
    } completion:^(PLVViewLogCustomParam * _Nonnull customParam) {
        [hud hideAnimated:YES];
        [weakSelf presentViewControllerWithChannelType:channelType];
    } failure:^(NSString * _Nonnull errorMessage) {
        [hud hideAnimated:YES];
        [weakSelf callbackResultOnce:callback isSucceed:NO errMsg:errorMessage];
    }];
}

WX_EXPORT_METHOD(@selector(loginPlaybackRoom:options:callback:))

- (void)loginPlaybackRoom:(NSInteger)sceneType
                  options:(NSDictionary *)options
                 callback:(WXModuleKeepAliveCallback)callback {
    NSString *channelId = [PLVLiveScenesUtils stringValueWithDictionary:options forKey:@"channelId" defaultValue:nil];
    //判空
    if(![PLVLiveScenesUtils isValidString:channelId]){
        [self callbackResultOnce:callback isSucceed:NO errMsg:@"channelId 不能为空"];
        return;
    }
    
    NSString *videoId = [PLVLiveScenesUtils stringValueWithDictionary:options forKey:@"videoId" defaultValue:nil];
    if(![PLVLiveScenesUtils isValidString:videoId]){
        [self callbackResultOnce:callback isSucceed:NO errMsg:@"videoId 不能为空"];
        return;
    }
    
//    BOOL isVodList = [options[@"videoType"] boolValue];
    PLVProgressHUD *hud = [PLVProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [hud.label setText:@"登录中..."];
    //判断场景
    PLVChannelType channelType = sceneType == 1 ? PLVChannelTypePPT | PLVChannelTypeAlone : PLVChannelTypeAlone;
    PLVLiveVideoConfig *videoConfig = [PLVLiveVideoConfig sharedInstance];
    __weak typeof(self) weakSelf = self;
    [PLVRoomLoginClient loginPlaybackRoomWithChannelType:channelType
                                               channelId:channelId
                                                     vid:videoId
                                                  userId:videoConfig.userId
                                                   appId:videoConfig.appId
                                               appSecret:videoConfig.appSecret
                                                roomUser:^(PLVRoomUser * _Nonnull roomUser) {
        //      可在此处配置自定义的登陆用户ID、昵称、头像，不配则均使用默认值
        //      PLVRoomViewUser *viewUser = [PLVLiveSDKConfig sharedSDK].viewUser;
        //      roomUser.viewerId = viewUser.viewerId;
        //      roomUser.viewerName = viewUser.viewerName;
        //      roomUser.viewerAvatar = viewUser.viewerAvatar;
    } completion:^(PLVViewLogCustomParam * _Nonnull customParam) {
        [hud hideAnimated:YES];
        [weakSelf presentViewControllerWithChannelType:channelType];
    } failure:^(NSString * _Nonnull errorMessage) {
        [hud hideAnimated:YES];
        [weakSelf callbackResultOnce:callback isSucceed:NO errMsg:errorMessage];
    }];
}

#pragma mark -- Private

- (void)presentViewControllerWithChannelType:(PLVChannelType)channelType {
    if (channelType == (PLVChannelTypePPT | PLVChannelTypeAlone)) {
        PLVLCCloudClassViewController * cloudClassVC = [[PLVLCCloudClassViewController alloc] init];
        cloudClassVC.modalPresentationStyle = UIModalPresentationFullScreen;
        UIViewController *viewController = [[self class] dc_findCurrentShowingViewController];
        // 进入云课堂直播间
        [viewController presentViewController:cloudClassVC animated:YES completion:nil];
        
#if OpenBugly
        PLVRoomUser *roomUser = [PLVRoomDataManager sharedManager].roomData.roomUser;
        [PLVBugReporter setUserIdentifier:roomUser.viewerId];
#endif
    } else if (channelType == PLVChannelTypeAlone) {
        PLVECWatchRoomViewController * watchLiveVC = [[PLVECWatchRoomViewController alloc] init];
        watchLiveVC.modalPresentationStyle = UIModalPresentationFullScreen;
        UIViewController *viewController = [[self class] dc_findCurrentShowingViewController];
        // 进入云课堂直播间
        [viewController presentViewController:watchLiveVC animated:YES completion:nil];
        
#if OpenBugly
        PLVRoomUser *roomUser = [PLVRoomDataManager sharedManager].roomData.roomUser;
        [PLVBugReporter setUserIdentifier:roomUser.viewerId];
#endif
    }
}

//获取当前显示的UIViewController
+ (UIViewController *)dc_findCurrentShowingViewController{
    //获取当前活动窗口的根识图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowingVC = [self findCurrentShowingViewControllerFrom:vc];
    return currentShowingVC;
}

+ (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController*)vc{
    //递归方法
    UIViewController *currentShowingVC;
    if([vc presentedViewController]){
        //当前视图是被presented出来的
        UIViewController *nextRootVC = [vc presentedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
    } else if([vc isKindOfClass:[UITabBarController class]]){
        // 根视图为UITabBarController
        UIViewController *nextRootVC = [(UITabBarController *)vc selectedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
    } else if ([vc isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UIViewController *nextRootVC = [(UINavigationController *)vc visibleViewController];
        currentShowingVC = nextRootVC;
        //        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];
    } else {
        // 根视图为非导航类
        currentShowingVC = vc;
    }
    
    return currentShowingVC;
}
- (void)callbackResultOnce:(WXModuleKeepAliveCallback)callback
                 isSucceed:(BOOL)isSucceed
                    errMsg:(NSString*)errMsg {
    if(callback){
        callback(@{@"isSuccess": @(isSucceed), @"errMsg": errMsg}, NO);
    }
}
@end
