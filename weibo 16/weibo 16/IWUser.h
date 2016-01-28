//
//  IWUser.h
//  weibo 16
//
//  Created by 何建新 on 16/1/25.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWUser : NSObject

@property(nonatomic, copy)NSString *screen_name;
//用户头像地址
@property(nonatomic, copy)NSString *profile_image_url;
@end
