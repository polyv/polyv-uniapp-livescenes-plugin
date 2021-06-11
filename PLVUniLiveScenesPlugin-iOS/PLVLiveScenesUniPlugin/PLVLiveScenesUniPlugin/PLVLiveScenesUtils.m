//
//  PLVLiveScenesUtils.m
//  PLVLiveScenesUniPlugin
//
//  Created by Sakya on 2021/5/8.
//

#import "PLVLiveScenesUtils.h"

@implementation PLVLiveScenesUtils

+ (BOOL)isValidString:(NSString *)param {
    return (param && [param isKindOfClass:[NSString class]] && param.length > 0);
}

+ (BOOL)validateVid:(NSString *)vid {
    if(![self isValidString:vid]){
        return NO;
    } else {
        NSString *VID = @"^[[a-z]|[0-9]]{32}_[[a-z]|[0-9]]$";
        NSPredicate *regexVid = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",VID];
        return [regexVid evaluateWithObject:vid];
    }
}

+ (NSString *)stringValueWithDictionary:(NSDictionary *)dict
                                forKey:(NSString *)key
                          defaultValue:(NSString *)defaultValue {
    if (![defaultValue isKindOfClass:[NSString class]] || defaultValue.length == 0) {
        defaultValue = nil;
    }
    
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return defaultValue;
    }
    
    if (!key || ![key isKindOfClass:[NSString class]] || key.length == 0) {
        return defaultValue;
    }
    
    return dict[key] ?: defaultValue;
}

+ (NSInteger)integerValueWithDictionary:(NSDictionary *)dict
                                 forKey:(NSString *)key
                           defaultValue:(NSInteger)defaultValue {
    if (!dict || ![dict isKindOfClass:[NSDictionary class]]) {
        return defaultValue;
    }
    id enableValue = [dict objectForKey:key];
    if ([enableValue isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)enableValue).integerValue;
    }
    return defaultValue;
}

@end
