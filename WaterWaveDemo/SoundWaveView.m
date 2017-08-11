//
//  SoundWaveView.m
//  咻一咻
//
//  Created by Wangyongxin on 2017/3/30.
//  Copyright © 2017年 Wangyongxin. All rights reserved.
//

#import "SoundWaveView.h"
#import "NSTimer+XXBlocksSupport.h"
#define INTERVAL_TIME 0.6f
#define TIGGER_Width self.frame.size.width

#define NUMBER_OF_PLIES 4

@interface SoundWaveView()<CAAnimationDelegate>{
    
    UIImageView * triggerBtn;
    
    NSTimer * soundWavetimer;
    
    CAShapeLayer * _waveLayer;
    
    NSMutableArray * layerArr;
    
}

@end

@implementation SoundWaveView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (soundWavetimer) {
            [soundWavetimer invalidate];
            soundWavetimer = nil;
        }
        __weak SoundWaveView *weakSelf = self;
        soundWavetimer = [NSTimer xx_scheduledTimerWithTimeInterval:.5
                                                     block:^{
                                                         SoundWaveView *strongSelf = weakSelf;
                                                         _waveLayer = [strongSelf cyccleLayer];
                                                         [strongSelf.layer insertSublayer:_waveLayer below:triggerBtn.layer];
                                                         [strongSelf soundWaveAnimation:_waveLayer];
                                                     }
                                                   repeats:YES];
        [self configureView];
        [self roundLayer:triggerBtn.frame];
    }
    return self;
}
-(void)configureView{
    triggerBtn = [[UIImageView alloc]init];
    triggerBtn.image = [UIImage imageNamed:@"finger"];
    triggerBtn.frame= CGRectMake(0, 0, TIGGER_Width, TIGGER_Width);
    triggerBtn.center = CGPointMake(CGRectGetHeight(self.frame) / 2, CGRectGetWidth(self.frame) / 2);
    triggerBtn.layer.cornerRadius = TIGGER_Width / 2;
    triggerBtn.clipsToBounds = YES;
    triggerBtn.backgroundColor = [UIColor redColor];
    [self addSubview:triggerBtn];
}
/**
 根据需要创建layer 添加数组
 @param frame frame
 */
-(void)roundLayer:(CGRect)frame{
    layerArr = [NSMutableArray array];
    //为了不间断弹出，预定层数加一
    for (int i = 0; i < NUMBER_OF_PLIES + 1; i++ ) {
        CGRect frame = triggerBtn.frame;
        CAShapeLayer * layer = [CAShapeLayer layer];
        layer.path = [UIBezierPath bezierPathWithRoundedRect:frame cornerRadius:TIGGER_Width / 2].CGPath;
        layer.bounds = frame;
        layer.position = triggerBtn.center;
        layer.fillColor = [UIColor colorWithRed:46/255.0f green:202/255.0f blue:255/255.0f alpha:1.f].CGColor;
        layer.frame = frame;
        [self.layer insertSublayer:_waveLayer below:triggerBtn.layer];
        [layerArr addObject:layer];
    }
}

-(CAShapeLayer *)cyccleLayer{
    CAShapeLayer * resultLayer = [layerArr firstObject];
    [layerArr removeObject:resultLayer];
    [layerArr addObject:resultLayer];
    
    return resultLayer;
}

-(void)triggerBtnClick:(id)sender{
    
    if (soundWavetimer) {
        [soundWavetimer invalidate];
        soundWavetimer = nil;
    }
    soundWavetimer = [NSTimer scheduledTimerWithTimeInterval:INTERVAL_TIME repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        _waveLayer = [self cyccleLayer];
        //        NSLog(@"%@",_waveLayer);
        [self.layer insertSublayer:_waveLayer below:triggerBtn.layer];
        [self soundWaveAnimation:_waveLayer];
        
    }];
}

-(void)soundWaveAnimation:(CAShapeLayer *)layer{
    
    /*
     struct CATransform3D
     
     {
     CGFloat    m11（x缩放）,    m12（y切变）,      m13（旋转）,    m14（）;
     
     CGFloat    m21（x切变）,    m22（y缩放）,      m23（）       ,    m24（）;
     
     CGFloat    m31（旋转）  ,    m32（ ）       ,      m33（）       ,    m34（透视效果，要操作的这个对象要有旋转的角度，否则没有效果。正直/负值都有意义）;
     
     CGFloat    m41（x平移）,    m42（y平移）,    m43（z平移） ,    m44（）;
     };
     */
    
    CABasicAnimation * basicAnimation =  [CABasicAnimation animationWithKeyPath:@"transform"];
    basicAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(4, 4, 1)];
    
    CABasicAnimation * opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue = @0.75;
    opacity.toValue = @0;
    
    CAAnimationGroup * group = [CAAnimationGroup animation];
    group.duration = INTERVAL_TIME * NUMBER_OF_PLIES;
    group.animations = @[basicAnimation,opacity];
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    group.delegate =self;
    [group setValue:layer forKey:@"layerkey"];
    [layer addAnimation:group forKey:@"group"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    CAShapeLayer * layer = (CAShapeLayer *)[anim valueForKey:@"layerkey"];
    [layer removeFromSuperlayer];
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
