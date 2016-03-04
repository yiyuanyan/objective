//
//  AddViewController.m
//  AddressBook2
//
//  Created by 何建新 on 16/3/2.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "AddViewController.h"
#import "JKContactModel.h"
@interface AddViewController ()
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
- (IBAction)AddAction;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}
-(void)textChange{
    self.addBtn.enabled = (self.nameField.text.length && self.phoneField.text.length);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)AddAction {
    //关闭当前视图控制器
    [self.navigationController popViewControllerAnimated:YES];
    //判断代理是否响应
    if ([self.delegate respondsToSelector:@selector(addContact:didAddContact:)]) {
        JKContactModel *contactModel = [[JKContactModel alloc] init];
        contactModel.name = self.nameField.text;
        contactModel.phone = self.phoneField.text;
        [self.delegate addContact:self didAddContact:contactModel];
    }
}
@end
