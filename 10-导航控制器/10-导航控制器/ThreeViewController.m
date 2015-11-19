//
//  ThreeViewController.m
//  10-导航控制器
//
//  Created by 何建新 on 15/11/16.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ThreeViewController.h"
#import "OneViewController.h"
@interface ThreeViewController ()
- (IBAction)back:(UIButton *)sender;
- (IBAction)returnRootCon:(UIButton *)sender;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)back:(UIButton *)sender {
    //弹出到上一个控制器
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)returnRootCon:(UIButton *)sender {
    //NSArray *arr = self.navigationController.viewControllers;
    
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
}
@end
