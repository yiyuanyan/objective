//
//  CZItem.h
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/2.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZItem : NSObject
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *icon;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
@end
