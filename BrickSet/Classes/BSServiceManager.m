//
//  BSServiceManager.m
//  HappyRoom
//
//  Created by Captain Black on 2016/11/29.
//  Copyright © 2016年 Aipai. All rights reserved.
//

#import "BSServiceManager.h"
#import <objc/runtime.h>
#import "NSObject+BrickSet.h"


NSString * const BSServiceRegisteredNotification = @"BSServiceRegisteredNotification";
NSString * const BSServiceDeregisteredNotification = @"BSServiceDeregisteredNotification";
NSString * const BSServiceKey = @"BSServiceKey";
NSString * const BSServiceClassKey = @"BSServiceClassKey";

@interface BSServiceManager ()
@property (nonatomic, strong) NSMutableDictionary *serviceInfo;
@property (nonatomic, strong) NSMutableDictionary *singletonService;
@end

@implementation BSServiceManager
static BSServiceManager *g_srvMgr = nil;

#pragma mark - singleton
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (g_srvMgr) {
        [[NSException exceptionWithName:@"SingletonException"
                                 reason:@"BSServiceManager singleton instance exists"
                               userInfo:nil]
         raise];
        return nil;
    }
    return [super allocWithZone:zone];
}

+ (instancetype)sharedInstance {
    if (!g_srvMgr) {
        g_srvMgr = [[BSServiceManager alloc] init];
    }
    return g_srvMgr;
}

- (void)dealloc {
    if (g_srvMgr == self) {
        g_srvMgr = nil;
    }
}

#pragma mark -
- (void)registerClass:(Class)class forService:(Protocol *)serviceProtocol {
    if (!protocol_conformsToProtocol(serviceProtocol, @protocol(BSService))) {
        [[NSException exceptionWithName:@"BrickSetException"
                                 reason:@"serviceProtocol must conforms to BSService"
                               userInfo:nil]
         raise];
        return;
    }
    if (![class conformsToProtocol:serviceProtocol]) {
        [[NSException exceptionWithName:@"BrickSetException"
                                 reason:[NSString stringWithFormat:@"class must conforms to %@", NSStringFromProtocol(serviceProtocol)]
                               userInfo:nil]
         raise];
        return;
    }
    self.serviceInfo[NSStringFromProtocol(serviceProtocol)] = NSStringFromClass(class);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BSServiceRegisteredNotification
                                                        object:nil
                                                      userInfo:@{BSServiceKey:serviceProtocol,
                                                                 BSServiceClassKey:class
                                                                 }];
}

- (void)unregisterService:(Protocol *)serviceProtocol {
    NSString *serviceKey = NSStringFromProtocol(serviceProtocol);
    Class class = NSClassFromString(self.serviceInfo[serviceKey]);
    
    if (class) {
        [self.serviceInfo removeObjectForKey:serviceKey];
        [self.singletonService removeObjectForKey:serviceKey];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:BSServiceDeregisteredNotification
                                                            object:nil
                                                          userInfo:@{BSServiceKey:serviceProtocol,
                                                                     BSServiceClassKey:class
                                                                     }];
    }
    
}

- (id<BSService>)instanceForService:(Protocol *)serviceProtocol {
    NSString *serviceKey = NSStringFromProtocol(serviceProtocol);
    id<BSService> srv = self.singletonService[serviceKey];
    if (srv) {
        return srv;
    }
    
    Class class = NSClassFromString(self.serviceInfo[serviceKey]);
    if (!class) {
        return nil;
    }
    
    srv = [[class alloc] init];
    BOOL singleton = [class respondsToSelector:@selector(singleton)] && [class singleton];
    if (srv && singleton) {
        self.singletonService[serviceKey] = srv;
    }
    return srv;
}

#pragma mark - getter & setter
- (NSMutableDictionary *)serviceInfo {
    if (!_serviceInfo) {
        _serviceInfo = [NSMutableDictionary dictionary];
    }
    return _serviceInfo;
}

- (NSMutableDictionary *)singletonService {
    if (!_singletonService) {
        _singletonService = [NSMutableDictionary dictionary];
    }
    return _singletonService;
}

@end
