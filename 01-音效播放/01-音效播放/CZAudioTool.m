//
//  CZAudioTool.m
//  01-音效播放
//
//  Created by 何建新 on 16/1/17.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZAudioTool.h"
#import <AVFoundation/AVFoundation.h>
//音效ID
static SystemSoundID _soundID;
static NSMutableDictionary *allSounds;
//音效播放类
@implementation CZAudioTool

+(NSMutableDictionary *)playWithFileName:(NSString *)fileName{
    //名称为空直接返回
    if (fileName != nil) {
    //在bundle中查找文件
    NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:nil];
    //找不到文件直接返回
    if (path != nil) {
        //生成文件路径
        NSURL *url = [NSURL fileURLWithPath:path];
        //现在字典中查找是否记录了这个音频的soundID
        SystemSoundID soundID = [allSounds[fileName] unsignedIntValue];
        _soundID = soundID;
        if (!_soundID) {
            //没有值绑定soundID和音频文件
            AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &_soundID);
            //保存sounID到字典中
            allSounds[fileName] = @(_soundID);
        }
        //播放
        AudioServicesPlaySystemSound(_soundID);
    }
    }
    return allSounds;
}
@end
