//
//  IWStatues.m
//  weibo 16
//
//  Created by 何建新 on 16/1/25.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWStatus.h"
#import "MJExtension.h"
#import "IWPhoto.h"

@implementation IWStatus
+ (NSDictionary *)objectClassInArray{
    return @{@"pic_urls" : [IWPhoto class]};
}
@end
