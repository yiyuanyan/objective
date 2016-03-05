//
//  getNetworkQuest.h
//  Login
//
//  Created by 何建新 on 16/3/4.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface getNetworkQuest : NSObject
@property(nonatomic, assign)NSData *data;


-(void)sendGetQuest2:(NSString *)urlStr param:(NSString *)param;
@end
