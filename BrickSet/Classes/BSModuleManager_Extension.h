//
//  BSModulesManager_Extension.h
//  HappyRoom
//
//  Created by Captain Black on 2016/11/28.
//  Copyright © 2016年 Aipai. All rights reserved.
//

#import "BSModuleManager.h"
#import "NSObject+BrickSet.h"

@interface BSModuleInfo : NSObject
@property (nonatomic, copy) NSString *cls;
@property (nonatomic, strong) id<BSModule> modulesInstance;
@end

@interface BSModuleManager ()
@property (nonatomic, strong) NSMutableDictionary *modules;
@property (nonatomic, strong) id<UIApplicationDelegate> mainModule;
@end
