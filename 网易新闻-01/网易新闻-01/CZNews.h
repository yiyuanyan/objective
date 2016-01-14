//
//  CZNews.h
//  网易新闻-01
//
//  Created by 何建新 on 16/1/14.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZNews : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy)NSNumber *replyCount;
@property(nonatomic, copy)NSString *digest;
@property(nonatomic, copy)NSString *imgsrc;
@property(nonatomic, copy)NSArray *imgextra;
@property(nonatomic ,copy)NSNumber *imgType;


+(instancetype)newsWithDic:(NSDictionary *)dic;
//发送异步请求获取数据
+(void)newsListWithUrl:(NSString *)urlStr success:(void(^)(NSArray *array))success error:(void(^)(NSError *err))error;
@end
