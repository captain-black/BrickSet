//
//  NSObject+BrickSet.m
//  HappyRoom
//
//  Created by Captain Black on 2016/11/28.
//  Copyright © 2016年 Aipai. All rights reserved.
//

#import "NSObject+BrickSet.h"
#import "BSModuleManager.h"
#import "BSServiceManager.h"


@implementation NSObject (BrickSet)

+ (BOOL)bs_setupModule:(Class)moduleClass {
    return [[BSModuleManager sharedInstance] setupModule:moduleClass];
}

+ (BOOL)bs_teardownModule:(Class)moduleClass {
    return [[BSModuleManager sharedInstance] teardownModule:moduleClass];
}

+ (void)bs_registerClass:(Class)cls forService:(Protocol *)serviceProtocol {
    [[BSServiceManager sharedInstance] registerClass:cls forService:serviceProtocol];
}

+ (void)bs_unregisterService:(Protocol *)serviceProtocol {
    [[BSServiceManager sharedInstance] unregisterService:serviceProtocol];
}

+ (id)bs_instanceForService:(Protocol *)serviceProtocol {
    return [[BSServiceManager sharedInstance] instanceForService:serviceProtocol];
}

@end
