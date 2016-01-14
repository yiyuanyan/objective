//
//  CZLoopImage.h
//  网易新闻
//
//  Created by 何建新 on 16/1/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZLoopImage : NSObject
//标题
@property(nonatomic, copy)NSString *title;
//图片地址
@property(nonatomic, copy)NSString *imgsrc;

+(instancetype)loopImage:(NSDictionary *)dic;

+ (void)loopImages:(void(^)(NSArray *array))success error:(void(^)(NSError *error))error;
@end
