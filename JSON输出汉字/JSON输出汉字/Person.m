//
//  Person.m
//  JSON输出汉字
//
//  Created by 何建新 on 15/12/21.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "Person.h"

@implementation Person
-(NSString *)description
{
    NSString *str = [NSString stringWithFormat:@"<%@,%p>{name:%@,age:%d}",[self class],self,self.name,self.age];
    return str;
}
@end
