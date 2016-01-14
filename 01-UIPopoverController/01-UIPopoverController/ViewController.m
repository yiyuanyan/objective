//
//  ViewController.m
//  01-UIPopoverController
//
//  Created by 何建新 on 16/1/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "CZTableViewController.h"
#import "CZOneViewController.h"
@interface ViewController ()
@property(nonatomic, strong)UIPopoverController *popover;
@property(nonatomic, strong)UIPopoverController *titlePopover;
- (IBAction)titleView:(UIButton *)sender;
@end

@implementation ViewController
- (IBAction)menuClick:(UIBarButtonItem *)sender {
    //3显示UIPopoverController指定的视图,presentPopoverFromBarButtonItem:触发的按钮.permittedArrowDirections:视图指向方向.animated:是否动画显示
    [self.popover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1创建内容控制器
    CZTableViewController *menuVc = [[CZTableViewController alloc] init];
    
    //2创建popover控制器
    UIPopoverController *popover = [[UIPopoverController  alloc] initWithContentViewController:menuVc];
    //
    self.popover = popover;
    
    
    //创建titlePopover
    CZOneViewController *one = [[CZOneViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:one];
    UIPopoverController *titlePopover = [[UIPopoverController alloc] initWithContentViewController:nav];
    self.titlePopover = titlePopover;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)titleView:(UIButton *)sender {
    [self.titlePopover presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
@end
