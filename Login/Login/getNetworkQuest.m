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
    /*[NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                self.json2 = json;
            }else{
                //return httpResponse.statusCode;
                self.code = httpResponse;
            }
        }else{
            //return @"2";
            self.code = connectionError;
        }
    }];*/
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.data = data;
    
    
}
//对URL参数进行编码
-(NSString *)encodeToRercentEscapeString:(NSString *)input{
    NSString *outputStr = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)input, NULL, (CFStringRef)@"!*'();:@&=+ $,/?%#[]", kCFStringEncodingUTF8));
    return outputStr;
}

@end
