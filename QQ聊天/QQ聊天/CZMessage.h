//
//  CZMessage.h
//  QQ聊天
//
//  Created by 何建新 on 15/10/28.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义枚举
typedef enum {
    CZMessageTypeMe,  //我
    CZMessageTypeOther  //其他人
}CZMessageType;


@interface CZMessage : NSObject
@property(nonatomic, copy)NSString *text;
@property(nonatomic, copy)NSString *time;
@property(nonatomic, assign)CZMessageType type;
//用于隐藏时间
@property(nonatomic, assign)BOOL hideTime;
//声明字典转模型方法
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)messageWithDict:(NSDictionary *)dict;
+(NSArray *)messages;
@end
