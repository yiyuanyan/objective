//
//  CZNews.h
//  模拟科技头条
//
//  Created by 何建新 on 15/12/22.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZNews : NSObject
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *img;
@property(nonatomic, copy)NSString *summary;
@property(nonatomic, copy)NSString *sitename;
@property(nonatomic, copy)NSString *addtime;
@property(nonatomic, copy, readonly)NSString *time;
+(instancetype)newsWithDic:(NSDictionary *)dic;
+(void)newsWithUrl:(NSString *)strUrl completion:(void(^)(NSArray *array))completion;
@end
