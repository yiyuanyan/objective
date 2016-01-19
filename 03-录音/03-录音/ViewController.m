//
//  ViewController.m
//  03-录音
//
//  Created by 何建新 on 16/1/17.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
@property(nonatomic, strong)AVAudioRecorder *recorder;
//专业定时器 每秒更新60次
@property(nonatomic, strong)CADisplayLink *link;
@end

@implementation ViewController
-(CADisplayLink *)link
{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateAudio)];
    }
    return _link;
}
-(void)updateAudio{
    //时时更新分贝
    [self.recorder updateMeters];
    
    //通过一个属性获取当前分贝
    CGFloat power = [self.recorder averagePowerForChannel:1];
    NSLog(@"%f",power);
}
//开始录音
- (IBAction)recoder:(UIButton *)sender {
    [self.recorder record];
    //开启定时器
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
//停止录音,自动保存文件
- (IBAction)stop:(UIButton *)sender {
    [self.recorder stop];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //沙盒路径,lastObject获得最终路径,stringByAppendingPathComponent:@""拼接文件名称
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.caf"];
    NSLog(@"%@",path);
    NSURL *url = [NSURL fileURLWithPath:path];
    //设置录音参数
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    //音频格式
    setting[AVFormatIDKey] = @(kAudioFormatAppleIMA4);
    //音频采样率
    setting[AVSampleRateKey] = @(8000.0);
    //音频通道数
    setting[AVNumberOfChannelsKey] = @(1);
    //线性音频的位深度
    setting[AVLinearPCMBitDepthKey] = @(8);
    //录音 settings:设置参数
    AVAudioRecorder *recorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:NULL];
    self.recorder = recorder;
    //允许监听
    self.recorder.meteringEnabled = YES;
    
    
}
@end
