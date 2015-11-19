//
//  TwoViewController.m
//  10-导航控制器
//
//  Created by 何建新 on 15/11/16.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "TwoViewController.h"
#import "ThreeViewController.h"
@interface TwoViewController ()
- (IBAction)jump2three:(UIButton *)sender;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"这是第二个控制器";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
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

- (IBAction)jump2three:(UIButton *)sender {
    UINavigationController *nav = self.navigationController;
    ThreeViewController *vc = [[ThreeViewController alloc]init];
    [nav pushViewController:vc animated:YES];
}
@end
