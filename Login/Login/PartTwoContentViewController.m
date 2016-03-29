//
//  PartTwoContentViewController.m
//  Login
//
//  Created by 何建新 on 16/3/28.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoContentViewController.h"

@interface PartTwoContentViewController ()

@end

@implementation PartTwoContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    
    
    
    
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
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
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
