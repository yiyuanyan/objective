//
//  Message.m
//  json转模型
//
//  Created by 何建新 on 15/12/21.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "Message.h"

@implementation Message
+(instancetype)messageWithDic:(NSDictionary *)dic
{
    Message *mes = [[Message alloc]init];
    [mes setValuesForKeysWithDictionary:dic];
    return mes;
}
-(NSString *)description
{
    
    
    return [NSString stringWithFormat:@"<%@,%p>{id:%d,messageId:%@,message:%@}",[self class],self,self.id,self.messageId,self.message];
}
@end
