//
//  AddViewController.m
//  03-通讯录
//
//  Created by 何建新 on 15/11/18.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
- (IBAction)addContact:(UIButton *)sender;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //给账户输入框设置监听方法和事件
    [self.nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    //给密码输入框设置监听方法和事件
    [self.numberField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
}


//账户输入框监听方法
-(void)textChange{
    if(self.nameField.text.length && self.numberField.text.length){
        self.addButton.enabled = YES;
    }else{
        self.addButton.enabled = NO;
    }
}
//保存按钮的点击事件
- (IBAction)addContact:(UIButton *)sender {
    //如果代理能够响应这个方法就执行下面代码
    if ([_addViewControllerDelegate respondsToSelector:@selector(addViewController:withName:andNumber:)]) {
        [_addViewControllerDelegate addViewController:self withName:self.nameField.text andNumber:self.numberField.text];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
@end
