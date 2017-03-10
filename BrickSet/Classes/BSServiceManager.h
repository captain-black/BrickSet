//
//  BSServiceManager.h
//  HappyRoom
//
//  Created by Captain Black on 2016/11/29.
//  Copyright © 2016年 Aipai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+BrickSet.h"

@interface BSServiceManager : NSObject

+ (instancetype)sharedInstance;

- (id<BSService>)instanceForService:(Protocol *)serviceProtocol;

- (void)registerClass:(Class)class forService:(Protocol *)serviceProtocol;

- (void)unregisterService:(Protocol *)serviceProtocol;

@end
