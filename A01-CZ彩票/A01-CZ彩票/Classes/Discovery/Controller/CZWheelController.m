//
//  CZWheelController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/1.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZWheelController.h"
#import "CZWheelView.h"
#import "UIView+Ex.h"
@interface CZWheelController ()

@end

@implementation CZWheelController

- (void)viewDidLoad {
    [super viewDidLoad];
    CZWheelView *view = [CZWheelView wheelView];
    
    [self.view addSubview:view];
    view.center = CGPointMake(self.view.center.x, self.view.center.y + 70);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//点击关闭按钮
- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
