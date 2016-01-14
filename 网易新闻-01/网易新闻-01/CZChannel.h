//
//  CZChannel.h
//  网易新闻-01
//
//  Created by 何建新 on 16/1/14.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZChannel : NSObject
@property(nonatomic, copy)NSString *tid;  //分类的ID
@property(nonatomic, copy)NSString *tname;  //分类名称
@property(nonatomic, copy, readonly)NSString *urlStr;
+(instancetype)channelWithDic:(NSDictionary *)dic;

+(NSArray *)channels;
@end
