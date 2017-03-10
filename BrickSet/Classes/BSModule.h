//
//  BSModule.h
//  BrickSet
//
//  Created by Captain Black on 2017/3/10.
//  Copyright © 2017年 captainblack. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BSModule <NSObject>

@optional
- (BOOL)modSetup;
- (BOOL)modTeardown;

@end
