//
//  JKContactModel.m
//  AddressBook2
//
//  Created by 何建新 on 16/3/2.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "JKContactModel.h"

@implementation JKContactModel
//对象归档必须执行的方法
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.phone forKey:@"phone"];
}
-(id)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
    }
    return self;
}
@end
