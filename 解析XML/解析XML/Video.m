//
//  Video.m
//  解析XML
//
//  Created by 何建新 on 15/12/23.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "Video.h"

@implementation Video
-(instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+(instancetype)videoWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
/*-(NSString *)description
{
    //return [NSString stringWithFormat:@"<%@,%@>{quantity:%@,itemdescription%@}",[self class],self,self.quantity,self.itemdescription];
}*/
@end
