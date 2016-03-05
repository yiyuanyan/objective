//
//  EditViewController.m
//  AddressBook2
//
//  Created by 何建新 on 16/3/2.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "EditViewController.h"
#import "JKContactModel.h"
@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)saveAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *edit;
- (IBAction)editAction:(UIBarButtonItem *)sender;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameField.text = self.contactModel.name;
    self.phoneField.text = self.contactModel.phone;
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}
-(void)textChange{
    self.saveBtn.enabled = (self.nameField.text.length && self.phoneField.text.length);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//保存
- (IBAction)saveAction:(id)sender {
    //关闭当前页面
    [self.navigationController popViewControllerAnimated:YES];
    //通知代理,如果代理响应了方法，就要更新数据
    if ([self.delegate respondsToSelector:@selector(enditeViewController:didSaveContact:)]) {
        //更新数据
        self.contactModel.name = self.nameField.text;
        self.contactModel.phone = self.phoneField.text;
        //调用代理方法
        [self.delegate enditeViewController:self didSaveContact:self.contactModel];
    }
}
//点击编辑按钮方法
- (IBAction)editAction:(UIBarButtonItem *)sender {
    if (self.nameField.enabled) {
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        //让这个视图的所有子视图不在允许编辑
        [self.view endEditing:YES];
        self.saveBtn.hidden = YES;
        sender.title = @"编辑";
        self.nameField.text = self.contactModel.name;
        self.phoneField.text = self.contactModel.phone;
    }else{
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        [self.view endEditing:YES];
        self.saveBtn.hidden = NO;
        sender.title = @"取消";
    }
}
@end
