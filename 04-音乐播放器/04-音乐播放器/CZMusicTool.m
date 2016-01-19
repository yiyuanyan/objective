//
//  CZMusicTool.m
//  04-音乐播放器
//
//  Created by 何建新 on 16/1/18.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZMusicTool.h"

@implementation CZMusicTool
static CZMusicTool *_INSTANCE;
+(instancetype)shareMusicTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _INSTANCE= [[CZMusicTool alloc]init];
    });
    return _INSTANCE;
}
-(void)playWithMusicFileName:(NSString *)fileName
{
    if (fileName == nil) {
        return;
    }
    NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:nil];
    if (!path) {
        return;
    }
    NSURL *url = [NSURL fileURLWithPath:path];
    self.player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:NULL];
    //准备播放
    [self.player prepareToPlay];
    //播放
    [self.player play];
}

-(void)pause{
    if (_player) {
        [_player pause];
    }
}
-(void)stop
{
    if (_player) {
        [_player stop];
    }
}
//当前时间
-(NSTimeInterval)currentTime
{
    return _player.currentTime;
}
//进度
-(CGFloat)progress
{
    return _player.currentTime / _player.duration;
}
-(NSTimeInterval)duration
{
    return _player.duration;
}
@end
