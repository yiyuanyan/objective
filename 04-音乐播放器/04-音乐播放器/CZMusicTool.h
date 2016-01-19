//
//  CZMusicTool.h
//  04-音乐播放器
//
//  Created by 何建新 on 16/1/18.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface CZMusicTool : NSObject
//单例
+(instancetype)shareMusicTool;
//播放
-(void)playWithMusicFileName:(NSString *)fileName;
//暂停
-(void)pause;
//停止播放
-(void)stop;
//必要对象属性
@property(nonatomic, strong)AVAudioPlayer *player;
//当前时间
-(NSTimeInterval)currentTime;
//进度
-(CGFloat)progress;
//总时长
-(NSTimeInterval)duration;
@end
