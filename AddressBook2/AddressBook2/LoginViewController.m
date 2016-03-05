//
//  LoginViewController.m
//  AddressBook2
//
//  Created by 何建新 on 16/3/2.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD+MJ.h"
#define UserNameKey @"name"
#define PwdKey @"pwd"
#define RmbPwdKey @"rmb_pwd"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UISwitch *rembSwitch;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)loginAction;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //观察者通知中心
    //实时监听文本框内容变化监听方法为textChange
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    //读取上次配置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.nameField.text = [defaults valueForKey:UserNameKey];
    //self.pwdField.text = [defaults valueForKey:PwdKey];
    self.rembSwitch.on = [defaults boolForKey:RmbPwdKey];
    if (self.rembSwitch.isOn) {
        self.pwdField.text = [defaults valueForKey:PwdKey];
        self.loginBtn.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)textChange{
    //判断按钮是否可以点击，如果两个文本框没有内容则不能点击
    self.loginBtn.enabled = (self.nameField.text.length && self.pwdField.text.length);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//页面跳转之前的准备工作
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //1。取得目标控制器
    UIViewController *contactVc = segue.destinationViewController;
    //设置标题
    contactVc.title = [NSString stringWithFormat:@"%@的联系人列表",self.nameField.text];
    
}


- (IBAction)loginAction {
    if (![self.nameField.text isEqualToString:@"hejianxin"]) {
        [MBProgressHUD showError:@"账号不存在"];
        return;
    }
    if (![self.pwdField.text isEqualToString:@"123456"]) {
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
    //提示努力加载中
    //[MBProgressHUD showMessage:@"努力加载中..."];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        //移除努力加载中
//        [MBProgressHUD hideHUD];
//        //跳转
        [self performSegueWithIdentifier:@"LoginToContact" sender:nil];
        
    //});
    //存储用户信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.nameField.text forKey:UserNameKey];
    [defaults setObject:self.pwdField.text forKey:PwdKey];
    [defaults setBool:self.rembSwitch.isOn forKey:RmbPwdKey];
    //设置同步，一定要同步
    [defaults synchronize];
    
}
@end
