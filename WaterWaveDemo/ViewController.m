//
//  ViewController.m
//  WaterWaveDemo
//
//  Created by 123456 on 2017/8/11.
//  Copyright © 2017年 hekai. All rights reserved.
//

#import "ViewController.h"
#import "SoundWaveView.h"
@interface ViewController ()
@property (nonatomic, strong) SoundWaveView *soundWaveView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.soundWaveView];
}

- (SoundWaveView *)soundWaveView {
    if (!_soundWaveView) {
        _soundWaveView = [[SoundWaveView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 60, 60)];
        _soundWaveView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tipImageViewClick)];
        [_soundWaveView addGestureRecognizer:tap];
    }
    return _soundWaveView;
}
//点击回调
- (void)tipImageViewClick {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
