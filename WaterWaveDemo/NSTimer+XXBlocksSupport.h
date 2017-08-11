//
//  NSTimer+XXBlocksSupport.h
//  XianjinXia
//
//  Created by 123456 on 2017/7/20.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (XXBlocksSupport)
+ (NSTimer *)xx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats;
@end
