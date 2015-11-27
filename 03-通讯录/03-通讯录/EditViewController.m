//
//  EditViewController.m
//  03-通讯录
//
//  Created by 何建新 on 15/11/19.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)editClick:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
- (IBAction)save:(UIButton *)sender;

@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",self.con.name);
    self.nameField.text = self.con.name;
    self.numberField.text = self.con.number;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击编辑按钮
- (IBAction)editClick:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"]) {
        self.saveButton.hidden = NO;
        sender.title = @"取消";
        self.nameField.enabled = YES;
        self.numberField.enabled = YES;
        [self.numberField becomeFirstResponder];
    }else{
        sender.title = @"编辑";
        self.saveButton.hidden = YES;
        self.nameField.enabled = NO;
        self.numberField.enabled = NO;
        self.nameField.text = self.con.name;
        self.numberField.text = self.con.number;
    }
}
- (IBAction)save:(UIButton *)sender {
    Contact *contact = self.con;
    contact.name = self.nameField.text;
    contact.number = self.numberField.text;
    [self.navigationController popViewControllerAnimated:YES];
}
@end
