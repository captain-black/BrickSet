//
//  BSModulesManager.m
//  HappyRoom
//
//  Created by Captain Black on 2016/11/28.
//  Copyright © 2016年 Aipai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSModuleManager_Extension.h"

@implementation BSModuleInfo
+ (void)load {
    ;
}
@end

@implementation BSModuleManager
static BSModuleManager *g_modMgr = nil;

#pragma mark - singleton
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (g_modMgr) {
        [[NSException exceptionWithName:@"SingletonException"
                                 reason:@"singleton instance exists"
                               userInfo:nil]
         raise];
        return nil;
    }
    return [super allocWithZone:zone];
}

+ (instancetype)sharedInstance {
    if (!g_modMgr) {
        g_modMgr = [[BSModuleManager alloc] init];
    }
    return g_modMgr;
}

- (void)dealloc {
    if (g_modMgr == self) {
        g_modMgr = nil;
    }
}

#pragma mark -
- (BOOL)setupModule:(Class)modulueClass {
    if (![modulueClass conformsToProtocol:@protocol(BSModule)]) {
        return NO;
    }
    
    NSString *className = NSStringFromClass(modulueClass);
    id<BSModule> module = self.modules[className];
    if (module) {
        return YES;
    }
    
    module = [[modulueClass alloc] init];
    if (!module) {
        return NO;
    }
    
    if ([module respondsToSelector:@selector(modSetup)]) {
        if (![module modSetup]) {
            return NO;
        }
    }
    
    self.modules[className] = module;
    
    return YES;
}

- (BOOL)teardownModule:(Class)modulueClass {
    NSString *className = NSStringFromClass(modulueClass);
    id<BSModule> module = self.modules[className];
    if (!module) {
        return NO;
    }
    
    if ([module respondsToSelector:@selector(modTeardown)]) {
        if (![module modTeardown]) {
            return NO;
        }
    }
    
    [self.modules removeObjectForKey:className];
    
    return YES;
}

#pragma mark - getter & setter
- (NSMutableDictionary *)modules {
    if (!_modules) {
        _modules = [NSMutableDictionary dictionary];
    }
    return _modules;
}

@end
