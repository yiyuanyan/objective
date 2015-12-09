//
//  CZQuestion.h
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/9.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZQuestion : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *html;
@property(nonatomic,copy)NSString *id;

+(instancetype)questionWithDic:(NSDictionary *)dic;
@end
