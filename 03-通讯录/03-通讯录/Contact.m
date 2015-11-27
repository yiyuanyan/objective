//
//  Contact.m
//  03-通讯录
//
//  Created by 何建新 on 15/11/19.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "Contact.h"

@implementation Contact
//解档
-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _number = [coder decodeObjectForKey:@"number"];
    }
    return self;
}
//归档
-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_number forKey:@"number"];
}
@end
