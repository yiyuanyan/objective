//
//  AddViewController.m
//  AddressBook
//
//  Created by 何建新 on 16/3/1.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "AddViewController.h"
#import "JKContactModel.h"
@interface AddViewController ()
- (IBAction)backAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)AddAction;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //观察者，检查textField发生变化时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(void)textChange{
    //任意为空则按钮不可用
    self.addBtn.enabled = (self.nameField.text.length && self.phoneField.text.length);
}
//让第一个文本框为第一响应者，进入页面自动打开键盘并且获取焦点
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //让textField成为第一响应者
    [self.nameField becomeFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backAction:(UIBarButtonItem *)sender {
}
//添加数据
- (IBAction)AddAction {
    //1关闭当前视图控制器
    [self.navigationController popViewControllerAnimated:YES];
    //判断是否响应代理方法
    if ([self.delegate respondsToSelector:@selector(addContact:didAddContact:)]) {
        //创建一个模型数据，
        JKContactModel *contactModel = [[JKContactModel alloc] init];
        //给模型数据中的属性进行赋值
        contactModel.name = self.nameField.text;
        contactModel.phone = self.phoneField.text;
        //调用模型中的代理方法，把创建的含有属性值的模型传递过去。这样值就传递过去了
        [self.delegate addContact:self didAddContact:contactModel];
    }
}
@end
