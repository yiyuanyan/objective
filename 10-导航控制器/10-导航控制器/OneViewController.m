//
//  OneViewController.m
//  10-导航控制器
//
//  Created by 何建新 on 15/11/16.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"
@interface OneViewController ()
- (IBAction)jump2two:(UIButton *)sender;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置nav的导航控制器标题
    self.navigationItem.title = @"第一个控制器";
    //创建一个UIBarButtonItem
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    //将导航返回按钮改成设置的item
    self.navigationItem.backBarButtonItem = item;
    //创建一个左上角barButtonItem
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:nil action:nil];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationItem.rightBarButtonItem = rightItem;
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

- (IBAction)jump2two:(UIButton *)sender {
    //获取父导航控制器
    UINavigationController *nav = self.navigationController;
    //创建第二个控制器
    TwoViewController *vc2 = [[TwoViewController alloc]init];
    [nav pushViewController:vc2 animated:YES];
    
}
@end
