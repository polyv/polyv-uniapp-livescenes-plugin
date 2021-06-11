//
//  PLVLiveScenesPluginProxy.m
//  PLVLiveScenesUniPlugin
//
//  Created by Sakya on 2021/5/10.
//

#import "PLVLiveScenesPluginProxy.h"

#import <PLVLiveScenesSDK/PLVLiveScenesSDK.h>

@implementation PLVLiveScenesPluginProxy

- (BOOL)application:(UIApplication *_Nullable)application didFinishLaunchingWithOptions:(NSDictionary *_Nullable)launchOptions {
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    // HttpDNS默认开启，如需关闭，解开注释
    [PLVLiveVideoConfig sharedInstance].enableHttpDNS = NO;
    // 如需启用IPV6，解开注释，启用IPV6之后，将自动选择IP，取消HttpDNS
//    [PLVLiveVideoConfig sharedInstance].enableIPV6 = YES;
    
    return YES;
}

/// 禁用第三方键盘，解决H5界面弹出第三方键盘时，界面不会往上推的问题（by CASE-30551）
- (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier {
    if ([extensionPointIdentifier isEqualToString:UIApplicationKeyboardExtensionPointIdentifier]) {
        return NO;
    }
    return YES;
}

@end
