//
//  IWAcount.m
//  weibo 16
//
//  Created by 何建新 on 16/1/23.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWAcount.h"

@implementation IWAcount
//指定自己身上的属性怎么归档
-(void)encodeWithCoder:(NSCoder *)encode{
    [encode encodeObject:self.access_token forKey:@"access_token"];
    [encode encodeInteger:self.expires_in forKey:@"expires_in"];
    [encode encodeObject:self.uid forKey:@"uid"];
    [encode encodeObject:self.remind_in forKey:@"remind_in"];
}
-(instancetype)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self) {
        self.expires_in = [decoder decodeIntegerForKey:@"expires_in"];
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.remind_in = [decoder decodeObjectForKey:@"remind_in"];
    }
    
    return self;
}
@end
