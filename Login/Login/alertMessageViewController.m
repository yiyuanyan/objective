//
//  alertMessageViewController.m
//  Login
//
//  Created by 何建新 on 16/3/4.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "alertMessageViewController.h"

@interface alertMessageViewController ()
@property(nonatomic, assign) UIAlertController *alert;
@end

@implementation alertMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(UIAlertController *)alertMessage:(NSString *)title message:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    //弹出信息的按钮
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *destuctiveBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:cancelBtn];
    [alert addAction:destuctiveBtn];
    return alert;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
