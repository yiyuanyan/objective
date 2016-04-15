//
//  StudyViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/14.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "StudyViewController.h"
#import "StudyTableViewCell.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "UIKit+AFNetworking.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface StudyViewController ()
@property(nonatomic, strong)UITableView *lianxiTableView;  //今日练习TableView
@property(nonatomic, strong) NSDictionary *lianxiDic;
@property(nonatomic, strong)UITableView *zhangwoTableView;  //我已掌握TableView
@property(nonatomic, strong) NSDictionary *zhangwoDic;
@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getJson:@"http://test.benniaoyasi.cn/api.php?m=api&c=Neveryday&a=index&appid=1&devtype=ios&version=1.0.1&device=iphone5s&mobile=18600562546" type:@"lianxiDic"];
    [self getJson:@"http://test.benniaoyasi.cn/api.php?m=api&c=Neveryday&a=grasp&appid=1&devtype=ios&version=1.0.1&device=iphone5s&mobile=18600562546" type:@"zhangwoDic"];
    //返回按钮
    UIBarButtonItem *goBackBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = goBackBtn;
    //去掉导航栏背景色和边框
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    //设置导航栏背景色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];;

    [self.navigationController setNavigationBarHidden:NO];
    //按钮view
    UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 40)];
    //今日练习按钮
    UIButton *lianxiBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-100, 0, 80, 40)];
    [lianxiBtn setTitle:@"今日练习" forState:UIControlStateNormal];
    [lianxiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnView addSubview:lianxiBtn];
    //创建今日练习tableView
    self.lianxiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-104) style:UITableViewStyleGrouped];
    self.lianxiTableView.backgroundColor = [UIColor blueColor];
    self.lianxiTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //设置tableView的代理和资源
    self.lianxiTableView.delegate = self;
    self.lianxiTableView.dataSource = self;
    self.lianxiTableView.tag = 100;
    //创建我已掌握tableView
    self.zhangwoTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-104) style:UITableViewStyleGrouped];
    self.zhangwoTableView.backgroundColor = [UIColor blackColor];
    self.zhangwoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.zhangwoTableView.delegate = self;
    self.zhangwoTableView.dataSource = self;
    self.zhangwoTableView.tag = 101;
    
    //创建
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 104)];
    scrollView.contentSize = CGSizeMake(kScreenWidth*2, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;

    
    [scrollView addSubview:self.lianxiTableView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:btnView];
    [self.view addSubview:scrollView];
}
//获取网络数据
-(void)getJson:(NSString *)http type:(NSString *)type{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:http parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([type isEqualToString:@"lianxiDic"]){
            self.lianxiDic = responseObject;
            [self.lianxiTableView reloadData];
        }else if([type isEqualToString:@"zhangwoDic"]){
            self.zhangwoDic = responseObject;\
            NSLog(@"%@",responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    
}
-(void)setDic:(NSDictionary *)dic{
    self.lianxiDic = dic;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)goBack{
    [super.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark --tableView的方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
//实现tableView的必要方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[StudyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    NSLog(@"%@",self.lianxiDic);
    cell.textLabel.text = @"asdfasdfsd";
    return cell;
}
//自定义titleHeader
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    customView.backgroundColor = [UIColor redColor];
    
    return customView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
//设置footer的高度。要想去掉footer必须设置为非零的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


@end
