//
//  ViewController.m
//  02-音乐播放
//
//  Created by 何建新 on 16/1/17.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
//使用强引用,防止播放后对象会被立即销毁
@property(nonatomic, strong)AVAudioPlayer *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //音乐地址
    NSString *path = [[NSBundle mainBundle]pathForResource:@"我爱你你却爱着她.mp3" ofType:nil];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    //创建一个播放器对象,并且绑定音乐文件
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:NULL];
    self.player = player;
    //缓冲
    [self.player prepareToPlay];
    
}
- (IBAction)play:(UIButton *)sender {
    //播放音乐
    [self.player play];
}
- (IBAction)pause:(UIButton *)sender {
    //暂停,在点击播放就继续播放
    [self.player pause];
}
- (IBAction)stop:(UIButton *)sender {
    //停止播放
    [self.player stop];
}


@end
