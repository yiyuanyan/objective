//
//  IWAcount.h
//  weibo 16
//
//  Created by 何建新 on 16/1/23.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWAcount : NSObject
@property(nonatomic, copy) NSString *access_token;
@property(nonatomic, assign) NSInteger expires_in;
@property(nonatomic, copy)NSString *remind_in;
@property(nonatomic, copy) NSString *uid;
@end
