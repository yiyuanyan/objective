//
//  Province.h
//  03-城市的选择
//
//  Created by 何建新 on 15/11/11.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject
@property(nonatomic, strong)NSArray *cities;
@property(nonatomic, copy)NSString *name;

+(instancetype)proinceWithDict:(NSDictionary *)dict;
@end
