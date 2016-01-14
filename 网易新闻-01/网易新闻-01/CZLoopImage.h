//
//  CZLoopImage.h
//  网易新闻-01
//
//  Created by 何建新 on 16/1/13.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZLoopImage : NSObject
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *imgsrc;
+(instancetype)loopImage:(NSDictionary *)dic;
//发送网络请求获取数据,异步请求,无法返回数据.使用回到函数
+(void)loopImages:(void(^)(NSArray *array))success error:(void(^)(NSError *e))error;
@end
