//
//  NSObject+BrickSet.h
//  HappyRoom
//
//  Created by Captain Black on 2016/11/28.
//  Copyright © 2016年 Aipai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSModule.h"
#import "BSService.h"

@interface NSObject (BrickSet)

+ (BOOL)bs_setupModule:(Class)moduleClass;

+ (BOOL)bs_teardownModule:(Class)moduleClass;

+ (void)bs_registerClass:(Class)cls forService:(Protocol *)serviceProtocol;

+ (void)bs_unregisterService:(Protocol *)serviceProtocol;

+ (id)bs_instanceForService:(Protocol *)serviceProtocol;

@end

#define BSService(name) [NSObject bs_instanceForService:@protocol(name)]
