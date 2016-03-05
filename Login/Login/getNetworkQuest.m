//
//  getNetworkQuest.m
//  Login
//
//  Created by 何建新 on 16/3/4.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "getNetworkQuest.h"
#import <CommonCrypto/CommonCrypto.h>
@implementation getNetworkQuest

-(void)sendGetQuest2:(NSString *)urlStr param:(NSString *)param{
    [self sendGetQuest:urlStr param:param];
}

-(void)sendGetQuest:(NSString *)urlStr param:(NSString *)param{
    //NSURL *url = [NSURL URLWithString:urlStr];
    
    NSString *httpUrl = [NSString stringWithFormat:@"%@?%@",urlStr,param];
    NSLog(@"%@",httpUrl);
    NSURL *url = [NSURL URLWithString:httpUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.data = data;
    
    
}

@end
