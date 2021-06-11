//
//  PLVLiveScenesUtils.h
//  PLVLiveScenesUniPlugin
//
//  Created by Sakya on 2021/5/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PLVLiveScenesUtils : NSObject

/// 检查 param 是否为不为空字符串
+ (BOOL)isValidString:(NSString *)param;

/// 检查 vid 是否格式正确且合法
+ (BOOL)validateVid:(NSString *)vid;

/// 读取字典 NSString 类型值安全方法
+ (NSString * _Nullable)stringValueWithDictionary:(NSDictionary *)dict
                                           forKey:(NSString *)key
                                     defaultValue:(NSString * _Nullable)defaultValue;
/**
 读取字典中的NSInteger 值
 */
+ (NSInteger)integerValueWithDictionary:(NSDictionary *)dict
                                 forKey:(NSString *)key
                           defaultValue:(NSInteger)defaultValue;
@end

NS_ASSUME_NONNULL_END
