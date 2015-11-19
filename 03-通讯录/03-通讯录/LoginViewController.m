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
    if(self.accountField.text.length && self.passwordField.text.length){
        self.loginButton.enabled = YES;
    }else{
        self.loginButton.enabled = NO;
    }
}
//点击登录按钮事件，跳转到segua的id为login2contacts所指向的界面
- (IBAction)login:(UIButton *)sender {
    [MBProgressHUD showMessage:@"正在加载"];
    //延时多少秒执行闭包内代码
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        if ([self.accountField.text isEqualToString:@"hjx"] && [self.passwordField.text isEqualToString:@"hjx"]) {
            
            [self performSegueWithIdentifier:@"login2contacts" sender:nil];
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
