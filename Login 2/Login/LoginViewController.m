//
//  LoginViewController.m
//  Login
//
//  Created by 何建新 on 16/3/4.
//  Copyright © 2016年 何建新. All rights reserved.
//
/*
 登陆URL
 http://test.benniaoyasi.cn/api.php?appid=1&m=api&c=user&a=login&devtype=ios&mobile=18600562546&password=123456&ip=114.241.188.141&device=iPhone5%20(A1429/A1442)&version=4.4.7&uuid=KY-21DCEFDF-5B85-4FF9-9A5D-5C3AD103D083&deviceToke=8cfb4db4192d4d299c58411d177d0516370ee70f29b206fb93a9436f46be7b7f
 */

#import "LoginViewController.h"
#import "alertMessageViewController.h"
#import "getNetworkQuest.h"
#import "CategoryTableViewController.h"
#define UserName @"username"
#define RmbSwitch @"remLogin"
#define UserPwd @"userpwd"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property(nonatomic, copy) NSDictionary *json;
- (IBAction)loginAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISwitch *rememberLogin;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    //读取上次保存的配置信息
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.rememberLogin.on = [defaults boolForKey:RmbSwitch];
    self.nameField.text = [defaults valueForKey:UserName];
    self.pwdField.text = [defaults valueForKey:UserPwd];
    if ((self.nameField.text.length >=6) && (self.pwdField.text.length >= 6) && (self.nameField.text.length <= 20) && (self.pwdField.text.length <= 20)) {
        self.loginBtn.enabled = YES;
    }
    if (self.rememberLogin.isOn && (self.nameField.text.length >=6) && (self.pwdField.text.length >= 6) && (self.nameField.text.length <= 20) && (self.pwdField.text.length <= 20)) {
        [self performSegueWithIdentifier:@"loginIdentifier" sender:nil];
    }
    
}
#pragma mark - 验证用户名&密码输入框内容是否发生变化
//用户名与密码输入框内容长度大于6且小于等于20的时候登陆按钮可用
-(void)textFieldChange{
    if ((self.nameField.text.length >= 6 && self.nameField.text.length <= 20) && (self.pwdField.text.length >= 6 && self.pwdField.text.length <= 20)) {
        self.loginBtn.enabled = YES;
    }else{
        self.loginBtn.enabled = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewController *tableViewController = segue.destinationViewController;
    tableViewController.title = [NSString stringWithFormat:@"%@",self.nameField.text];
}


- (IBAction)loginAction:(UIButton *)sender {

    
    getNetworkQuest *quest = [[getNetworkQuest alloc] init];
    NSString *http = @"http://test.benniaoyasi.cn/api.php";
    NSString *param = [NSString stringWithFormat:@"appid=1&m=api&c=user&a=login&devtype=ios&mobile=%@&password=%@&ip=114.241.188.141&version=4.4.7",self.nameField.text,self.pwdField.text];
   [quest sendGetQuest2:http param:param];
    NSData *data = quest.data;
    self.json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    if ([self.json[@"ecode"] isEqualToString:@"0"]) {
        [self rememberUser];
        [self performSegueWithIdentifier:@"loginIdentifier" sender:nil];
    }else{
        alertMessageViewController *alert = [alertMessageViewController alertMessage:@"错误信息" message:@"登陆失败，用户名或密码错误"];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    
}
//保存配置
-(void)rememberUser{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.nameField.text forKey:UserName];
    [defaults setBool:self.rememberLogin.isOn forKey:RmbSwitch];
    [defaults setObject:self.pwdField.text forKey:UserPwd];
    [defaults synchronize];
}
@end
