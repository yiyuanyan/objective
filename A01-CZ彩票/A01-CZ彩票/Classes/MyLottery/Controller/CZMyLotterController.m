//
//  CZMyLotterController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/2.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZMyLotterController.h"
#import "CZLoginController.h"
#import "CZSettingsController.h"
#import "UIImage+Ex.h"
@interface CZMyLotterController ()
@property (weak, nonatomic) IBOutlet UIButton *loginView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *configItem;
@end

@implementation CZMyLotterController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *img = [UIImage imageNamed:@"RedButton"];
    UIImage *selImg = [UIImage imageNamed:@"RedButtonPressed"];
    //拉伸图片
    img = [img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    
    [self.loginView setBackgroundImage:img forState:UIControlStateNormal];
    [self.loginView setBackgroundImage:selImg forState:UIControlStateHighlighted];
    //去掉设置按钮的蒙版
    self.navigationItem.rightBarButtonItem.image = [self.navigationItem.rightBarButtonItem.image originalImage];
    
}


- (IBAction)loginClick:(UIButton *)sender {
    //创建登录控制器
    CZLoginController *vc = [[CZLoginController alloc]init];
    //设置登录控制器页面的背景图片为白色
    vc.view.backgroundColor = [UIColor whiteColor];
    //给登录页面创建一个UINavigationController
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    //设置导航栏的标题
    vc.title = @"登录";
    
    //添加一个取消按钮。点击按钮触发返回事件
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    
    vc.navigationItem.leftBarButtonItems = @[back];
    [self presentViewController:navController animated:YES completion:nil];
}
-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)configClick:(id)sender {
    CZSettingsController *vc = [[CZSettingsController alloc] init];
    //设置标题
    vc.title = @"设置";
    NSString *title = @"常见问题";
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(questionClick)];
    vc.navigationItem.rightBarButtonItems = @[item];
    
    [self.navigationController pushViewController:vc animated:YES];
}

//点击常见问题
-(void)questionClick{

}

@end
