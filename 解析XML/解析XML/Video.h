//
//  Video.h
//  解析XML
//
//  Created by 何建新 on 15/12/23.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
@property(nonatomic, copy)NSString *quantity;
@property(nonatomic, copy)NSString *itemdescription;

//@property(nonatomic, readonly)NSString *time;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)videoWithDict:(NSDictionary *)dict;
@end
