//
//  LoginViewController.m
//  03-通讯录
//
//  Created by 何建新 on 15/11/18.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD/MBProgressHUD+MJ.h"
#import "ContactsViewController.h"

#define kAccountKey @"account"
#define kPwdKey @"passowrd"
#define kRemPwdSwitchKey @"remPwdSwitch"
#define kAutoLoginSwitchKey @"autoLoginSwitch"
@interface LoginViewController ()<UITextFieldDelegate>
//账号
@property (weak, nonatomic) IBOutlet UITextField *accountField;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
//记住密码
@property (weak, nonatomic) IBOutlet UISwitch *remPwdSwitch;
//自动登录
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
//登录按钮
- (IBAction)login:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.accountField.delegate = self;
    //给账户输入框设置监听方法和事件
    [self.accountField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    //给密码输入框设置监听方法和事件
    [self.passwordField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    
    //监听记住密码switch状态
    [self.remPwdSwitch addTarget:self action:@selector(remPwdSwitchChange) forControlEvents:UIControlEventValueChanged];
    //监听自动登录switch状态
    [self.autoLoginSwitch addTarget:self action:@selector(autoLoginSwitchChange) forControlEvents:UIControlEventValueChanged];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    self.accountField.text = [ud objectForKey:kAccountKey];
    
    self.remPwdSwitch.on = [ud boolForKey:kRemPwdSwitchKey];
    self.autoLoginSwitch.on = [ud boolForKey:kAutoLoginSwitchKey];
    //如果记住密码是开启状态在去给密码文本赋值
    if (self.remPwdSwitch.isOn) {
        self.passwordField.text = [ud objectForKey:kPwdKey];
    }
    if (self.autoLoginSwitch.isOn) {
        
        //[self login:nil];
    }
    //监听登录按钮是否可用
    [self textChange];
}
//通过segue跳转后比定执行这个方法。用来进行两个界面进行传值
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //destinationViewContriller为跳转到的控制器
    ContactsViewController *con = segue.destinationViewController;
    //拿到控制器对其属性赋值，达到两个页面间赋值
    con.userName = self.accountField.text;
    
}

//监听记住密码switch方法
-(void)remPwdSwitchChange
{
    if (self.remPwdSwitch.isOn) {
        //self.autoLoginSwitch.on = YES;
    }else{
        //self.autoLoginSwitch.on = NO;
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}
//监听自动登录switch方法
-(void)autoLoginSwitchChange
{
    if (self.autoLoginSwitch.isOn) {
        //self.remPwdSwitch.on  = YES;
        [self.remPwdSwitch setOn:YES animated:YES];
    }
}
//账户输入框监听方法
-(void)textChange{
    //判断用户名输入框和密码输入框是否有长度，没有则登录按钮不可用
    if(self.accountField.text.length && self.passwordField.text.length){
        self.loginButton.enabled = YES;
    }else{
        self.loginButton.enabled = NO;
    }
}
//点击登录按钮事件，跳转到segua的id为login2contacts所指向的界面
- (IBAction)login:(UIButton *)sender {
    //调用MBProgressHUD框架的showMessage:方法。弹出提示框
    [MBProgressHUD showMessage:@"正在加载"];
    //延时多少秒执行闭包内代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //关闭MBProgressHUD的提示框
        [MBProgressHUD hideHUD];
        //判断用户名和密码是否等于hjx
        if ([self.accountField.text isEqualToString:@"hjx"] && [self.passwordField.text isEqualToString:@"hjx"]) {
            //跳转到segue得ID为login2contacts的页面
            [self performSegueWithIdentifier:@"login2contacts" sender:nil];
            //保存登录信息
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setObject:self.accountField.text forKey:kAccountKey];
            [ud setObject:self.passwordField.text forKey:kPwdKey];
            [ud setBool:self.remPwdSwitch.isOn forKey:kRemPwdSwitchKey];
            [ud setBool:self.autoLoginSwitch.isOn forKey:kAutoLoginSwitchKey];
            //立即存储
            [ud synchronize];
        }else{
            //使用框架的类方法提示信息
            [MBProgressHUD showError:@"用户名活密码错误"];
        }
    });
    
}

//是否允许编辑
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//
//    return YES;
//}
//进入编辑状态时调用
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    textField.placeholder = nil;
//}
////是否允许结束编辑
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    return YES;
//}
////结束编辑时调用
//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    NSLog(@"%@",self.accountField.text);
//}
//是否允许用户输入文字,并监听用户输入之前的textField状态
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    return YES;
//}




@end
