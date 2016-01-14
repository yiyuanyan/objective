//
//  ViewController.m
//  POST登录
//
//  Created by 何建新 on 15/12/24.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonCrypto.h>
#import "SSKeychain.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameField;

@property (weak, nonatomic) IBOutlet UITextField *userPwdField;
@property(nonatomic, copy)NSString *userName;
@property(nonatomic, copy)NSString *userPwd;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadUserInfo];
    //获取当前钥匙串中所有用户
    
    
}


- (IBAction)loginButton:(id)sender {
    self.userName = [self str2URLencode:self.userNameField.text];
    self.userPwd = [self str2URLencode:self.userPwdField.text];
    [self login:@"http://10.14.16.11/iOS/login.php"];
}




//对字符串进行URL编码
-(NSString *)str2URLencode:(NSString *)str
{
    NSString *URLStr = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)str, NULL, (CFStringRef)@"!*'();:@&=+ $,/?%#[]", kCFStringEncodingUTF8));
    return URLStr;
}

@end
