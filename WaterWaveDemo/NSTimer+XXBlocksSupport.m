//
//  NSTimer+XXBlocksSupport.m
//  XianjinXia
//
//  Created by 123456 on 2017/7/20.
//  Copyright © 2017年 lxw. All rights reserved.
//

#import "NSTimer+XXBlocksSupport.h"

@implementation NSTimer (XXBlocksSupport)
+ (NSTimer *)xx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(xx_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
}

+ (void)xx_blockInvoke:(NSTimer *)timer {
    void (^block)() = timer.userInfo;
    if(block) {
        block();
    }
}
@end
