//
//  CZOneViewController.m
//  换肤
//
//  Created by 何建新 on 16/1/16.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZOneViewController.h"

@interface CZOneViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *heartOne;

@end

@implementation CZOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置
    [self setSkin];
}
-(void)setSkin{
    NSString *skin = [[NSUserDefaults standardUserDefaults]objectForKey:@"skin"];
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

@end
