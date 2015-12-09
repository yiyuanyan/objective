//
//  CZProduct.h
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/8.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZProduct : NSObject
/*
 "title": "网易电影票",
 "id": "com.netease.movie",
 "url": "http://itunes.apple.com/app/id583784224?mt=8",
 "icon": "movie",
 "customUrl": "movieticket163"
 */
@property(nonatomic, copy)NSString *icon;
@property(nonatomic, copy)NSString *id;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *customUrl;
@property(nonatomic, copy)NSString *url;

+(instancetype)productWithDic:(NSDictionary *)dic;
@end
