//
//  Message.h
//  json转模型
//
//  Created by 何建新 on 15/12/21.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property(nonatomic, strong)NSNumber *id;
@property(nonatomic, copy)NSString *messageId;
@property(nonatomic, copy)NSString *message;

+(instancetype)messageWithDic:(NSDictionary *)dic;
@end
