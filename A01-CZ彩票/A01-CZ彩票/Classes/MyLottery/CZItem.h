//
//  CZItem.h
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/2.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义一个block
typedef void (^CZItemOption)();
@interface CZItem : NSObject
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *icon;
@property(nonatomic, strong)Class desController;  //类属性
@property(nonatomic, copy) CZItemOption option;
@property(nonatomic, copy)NSString *subTitle;
@property(nonatomic, copy)NSString *time;

+(instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;
+(instancetype)itemWithTitle:(NSString *)title;
+(instancetype)itemWithTitle:(NSString *)title time:(NSString *)time;
@end
