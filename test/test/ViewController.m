//
//  ViewController.m
//  test
//
//  Created by 何建新 on 16/4/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
@property(nonatomic,strong)AVAudioPlayer *audioplayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [btn setTitle:@"播放音频" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(playMp3) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    NSURL *url = [NSURL URLWithString:@"http://test.benniaoyasi.cn/Public/Uploads/2016-03-28/56f8e04c3d4cc.mp3"];
    NSData *audioData = [NSData dataWithContentsOfURL:url];
    self.audioplayer = [[AVAudioPlayer alloc] initWithData:audioData error:nil];
    
    [self.audioplayer prepareToPlay];
    self.audioplayer.volume = 1.0;
    [self.view addSubview:btn];
    
}
-(void)playMp3{
    NSLog(@"播放音频");
    
    [self.audioplayer play];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
