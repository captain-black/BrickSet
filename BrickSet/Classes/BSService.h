//
//  BSService.h
//  BrickSet
//
//  Created by Captain Black on 2017/3/10.
//  Copyright © 2017年 captainblack. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BSService <NSObject>

/**
 告知BrickSet该服务是否单例。如果没有实现或者返回NO，BrickSet可以生成多个实例并不会对其持有。
 */
@optional
+ (BOOL)singleton;

@end
