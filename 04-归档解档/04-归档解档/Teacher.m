//
//  Teacher.m
//  04-归档解档
//
//  Created by 何建新 on 15/11/20.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "Teacher.h"

@implementation Teacher
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    //根据forKey:去取值
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeInt:_age forKey:@"age"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        //解档属性
        _name = [aDecoder decodeObjectForKey:@"name"];
        _age = [aDecoder decodeIntForKey:@"age"];
    }
    return self;
}
@end
