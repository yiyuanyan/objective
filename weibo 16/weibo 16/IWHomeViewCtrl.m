//
//  IWHomeViewCtrl.m
//  weibo 16
//
//  Created by 何建新 on 16/1/19.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWHomeViewCtrl.h"
#import "IWHomeTitleButton.h"
#import "IWTemp2ViewCtrl.h"
#import "IWPopView.h"
@interface IWHomeViewCtrl ()

@end

@implementation IWHomeViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
}
//设置导航栏的文字和图片
-(void)setupNav{
    //这只顶部导航栏titleView
    IWHomeTitleButton *titleBtn = [[IWHomeTitleButton alloc] init];
    [titleBtn setTitle:@"我叫首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //设置图片
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    
    [titleBtn sizeToFit];
    [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    
    
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_friendsearch" target:self action:@selector(friendsearch)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigationbar_pop" target:self action:@selector(pop)];
}
//顶部左侧按钮
-(void)friendsearch{
    NSLog(@"%s",__func__);
    //初始化自定义view
    IWTemp2ViewCtrl *temp2 = [[IWTemp2ViewCtrl alloc]init];
    //push页面
    [self.navigationController pushViewController:temp2 animated:YES];
}
//顶部右侧按钮
-(void)pop{
    NSLog(@"%s",__func__);
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    IWHomeTitleButton *titleBtn = (IWHomeTitleButton *)self.navigationItem.titleView;
//    [titleBtn setTitle:@"我叫" forState:UIControlStateNormal];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}


#pragma make - 私有方法
-(void)titleBtnClick:(UIButton *)btn{
    UIView *customView = [[UIView alloc] init];
    customView.backgroundColor = [UIColor redColor];
    customView.size = CGSizeMake(100, 100);
    IWPopView *popView = [[IWPopView alloc] initWithCustomsView:customView showView:btn];
    popView.backgroundColor = [UIColor clearColor];
    //获取当前window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //给window添加子视图，这样子视图沾满屏幕
    [window addSubview:popView];
    //[self.view addSubview:popView];
}
@end
