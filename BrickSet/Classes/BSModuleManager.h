//
//  BSModulesManager.h
//  HappyRoom
//
//  Created by Captain Black on 2016/11/28.
//  Copyright © 2016年 Aipai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSModuleManager : NSObject

+ (instancetype)sharedInstance;


/**
 安装模块

 @param cls 模块类，必须遵循BSModule协议
 @return 安装是否成功
 */
- (BOOL)setupModule:(Class)moduleClass;

- (BOOL)teardownModule:(Class)moduleClass;

@end
