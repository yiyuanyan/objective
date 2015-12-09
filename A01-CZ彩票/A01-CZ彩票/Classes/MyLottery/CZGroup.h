//
//  CZGroup.h
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/2.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZGroup : NSObject
@property(nonatomic, strong)NSArray *items;
@property(nonatomic, strong)NSString *header;
@property(nonatomic, strong)NSString *footer;
+(instancetype)groupWithItems:(NSArray *)items;

+(instancetype)groupWithHeader:(NSString *)header items:(NSArray *)items;

+(instancetype)groupWithFooter:(NSString *)footer items:(NSArray *)items;

+(instancetype)groupWithHeader:(NSString *)header footer:(NSString *)footer items:(NSArray *)items;
@end
