//
//  CZNews.h
//  网易新闻
//
//  Created by 何建新 on 16/1/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZNews : NSObject

@property(nonatomic, copy)NSNumber *replyCount;
@property(nonatomic, copy)NSString *digest;   //新闻摘要
@property(nonatomic, copy)NSString *title;  //标题
@property(nonatomic, copy)NSString *imgsrc;  //图标
@property(nonatomic, copy)NSArray *imgextra;
+(instancetype)newsWithDic:(NSDictionary *)dic;
//发送异步请求获取数据
+(void)newsList:(void(^)(NSArray *array))success error:(void(^)(NSError *err))error;
@end
