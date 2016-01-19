//
//  CZMusic.h
//  04-音乐播放器
//
//  Created by 何建新 on 16/1/18.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    kMusicTypeLocal, //本地
    kMusicTypeRemote  //远程
}kMusicType;
@interface CZMusic : NSObject
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *image;
@property(nonatomic, copy)NSString *lrc;
@property(nonatomic, copy)NSString *mp3;
@property(nonatomic, copy)NSString *singer;
@property(nonatomic, copy)NSString *zhuanji;
@property(nonatomic, assign)kMusicType type;
@end
