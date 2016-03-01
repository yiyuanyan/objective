//
//  LoginViewController.m
//  AddressBook
//
//  Created by 何建新 on 16/3/1.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recognizer)];
    [self.view addGestureRecognizer:recognizer];
    //添加观察者
    //注册一个通知，添加监听事件，object:为监听对象，这里如果输入的是nil则会监听所有textField的变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    //监听密码textField是否发生变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
}
-(void)recognizer{
    [self.nameField resignFirstResponder];
    [self.pwdField resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textChange{
    //判断textField是否有内容来修改登录按钮状态
//    if (self.nameField.text.length && self.pwdField.text.length) {
//        self.loginBtn.enabled = YES;
//    }else{
//        self.loginBtn.enabled = NO;
//    }
    self.loginBtn.enabled = (self.nameField.text.length && self.pwdField.text.length);
}
//跳转前的准备
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //取得目标控制器
    UIViewController *contactVc = segue.destinationViewController;
    //设置标题
    contactVc.title = [NSString stringWithFormat:@"%@的联系人列表",self.nameField.text];
}
- (IBAction)loginAction {
    //跳转到与本试图连线的下一个视图ID为LoginToContact的视图页面
    //sender参数是prepareForSegue:sender方法的sender.传值
    [self performSegueWithIdentifier:@"LoginToContact" sender:nil];
}

@end
