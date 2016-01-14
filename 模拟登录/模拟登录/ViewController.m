//
//  ViewController.m
//  模拟登录
//
//  Created by 何建新 on 15/12/23.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UITextField *pwdView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //加载保存的用户名和密码
    [self reloadUserInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//登录
- (IBAction)login:(id)sender {
    NSString *name = self.nameView.text;
    NSString *pwd = self.pwdView.text;
    //对特殊符号进行转意
    name = [self encodeToRercentEscapeString:name];
    pwd = [self encodeToRercentEscapeString:pwd];
    pwd = [self md5String:pwd];
    [self login:@"http://10.14.16.11/iOS/login.php" userName:name pwd:pwd];
}
-(void)login:(NSString *)strUrl userName:(NSString *)userName pwd:(NSString *)pwd{
    
    NSURL *url = [NSURL URLWithString:strUrl];
    //可变请求
    NSMutableURLRequest *quest = [NSMutableURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:15];
    //设置请求方式
    quest.HTTPMethod = @"post";
    NSString *userStr = [NSString stringWithFormat:@"username=%@&password=%@",userName,pwd];
    quest.HTTPBody = [userStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:quest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@",json);
                
                //判断登录是否成功
                if ([json[@"userId"] intValue] > 0) {
                    NSLog(@"登录成功");
                    //保存登录成功的用户
                    [self saveUserInfo];
                }else{
                    NSLog(@"登录失败");
                }
            }else{
                NSLog(@"服务器返回失败");
            }
        }else{
            NSLog(@"连接服务器失败");
        }
    }];
}
//对URL进行编码(不对空格和汉字进行编码)
-(NSString *)encodeToRercentEscapeString:(NSString *) input
{
    NSString *outputStr = (NSString *) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)input, NULL, (CFStringRef)@"!*'();:@&=+ $,/?%#[]", kCFStringEncodingUTF8));
    return outputStr;
}
//将用户输入的用户名和密码保存到用户偏好中
-(void)saveUserInfo{
    //获取用户偏好
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.nameView.text forKey:@"name"];
    [userDefaults setObject:[self md5String:self.pwdView.text] forKey:@"pwd"];
    //立即保存同步
    [userDefaults synchronize];
    NSLog(@"保存成功");
}
//从用户偏好中加载数据
-(void)reloadUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.nameView.text = [userDefaults objectForKey:@"name"];
    self.pwdView.text = [userDefaults objectForKey:@"pwd"];
}

//md5加密
-(NSString *)md5String:(NSString *)string
{
    const char *str = (char *)string.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
    
}
-(NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length{
    NSMutableString *strM = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x",bytes[i]];
    }
    return [strM copy];
}
@end
