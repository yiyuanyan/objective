//
//  CZArenaController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/11/27.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZArenaController.h"


#define kCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
@interface CZArenaController ()

@end

@implementation CZArenaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建导航栏
    UINavigationBar *navBar = self.navigationController.navigationBar;
    //导航栏背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"NLArenaNavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航的segmentedControl。初始化方法initWithItems是数组。可以根据内容自动控制一个开关按钮大小
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"足球",@"篮球"]];
    //segmentedControl.width = 120;
    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segmentedControl setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    //设置第一个默认选中
    segmentedControl.selectedSegmentIndex = 0;
    //选中的字体颜色
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    //未选中的文字颜色
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:kCOLOR(20,150,115)} forState:UIControlStateNormal];
    self.navigationItem.titleView = segmentedControl;
    [segmentedControl addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
}
-(void)valueChanged:(UISegmentedControl *)sender{
    //判断当前是第几个segment
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"第一个视图");
    }else{
        NSLog(@"第二个视图");
        
    }
    //获取当前对应的segment的文本标题
    NSString *title = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
    NSLog(@"选中的是%@",title);
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
