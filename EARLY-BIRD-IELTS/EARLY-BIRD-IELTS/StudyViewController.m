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
#define kStrFont [UIFont fontWithName:@"Arial" size:14]
#define kTitleStrFont [UIFont fontWithName:@"Arial" size:18]
@interface StudyViewController ()
@property(nonatomic, strong)UIScrollView *scrollView;
//scrollView当前页码
@property(nonatomic, assign)int currentPage;
@property(nonatomic, strong)UITableView *lianxiTableView;  //今日练习TableView
@property(nonatomic, strong) NSDictionary *lianxiDic;
@property(nonatomic, strong)UIButton *lianxiBtn;
@property(nonatomic, strong)UITableView *zhangwoTableView;  //我已掌握TableView
@property(nonatomic, strong) NSDictionary *zhangwoDic;
@property(nonatomic, strong) UIButton *zhangwoBtn;

@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
    self.lianxiBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth/2-100, 0, 80, 40)];
    [self.lianxiBtn setTitle:@"今日练习" forState:UIControlStateNormal];
    [self.lianxiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.lianxiBtn addTarget:self action:@selector(lianxiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //我已掌握
    self.zhangwoBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.lianxiBtn.frame.size.width+100, 0, 80, 40)];
    [self.zhangwoBtn setTitle:@"我已掌握" forState:UIControlStateNormal];
    [self.zhangwoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.zhangwoBtn addTarget:self action:@selector(zhangwoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:self.zhangwoBtn];
    [btnView addSubview:self.lianxiBtn];
    //创建今日练习tableView
    self.lianxiTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-104) style:UITableViewStyleGrouped];
    
    self.lianxiTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //设置tableView的代理和资源
    self.lianxiTableView.delegate = self;
    self.lianxiTableView.dataSource = self;
    self.lianxiTableView.tag = 100;
    //创建我已掌握tableView
    self.zhangwoTableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-104) style:UITableViewStyleGrouped];
    self.zhangwoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.zhangwoTableView.delegate = self;
    self.zhangwoTableView.dataSource = self;
    self.zhangwoTableView.tag = 101;
    
    //创建
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, kScreenWidth, [UIScreen mainScreen].bounds.size.height - 104)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth*2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    //去掉空白cell的线
    UIView *footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    [self.lianxiTableView setTableFooterView:footerView];
    [self.zhangwoTableView setTableFooterView:footerView];
    
    [self.scrollView addSubview:self.lianxiTableView];
    [self.scrollView addSubview:self.zhangwoTableView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:btnView];
    [self.view addSubview:self.scrollView];
}
-(void)zhangwoBtnClick{
    [UIView animateWithDuration:0.5 animations:^{
        //改变scrollView的x值
        self.scrollView.contentOffset = CGPointMake(320, 0);
    }];
    [self.zhangwoBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
    [self.lianxiBtn setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateNormal];
    
}
-(void)lianxiBtnClick{
    [UIView animateWithDuration:0.5 animations:^{
        //改变scrollView的x值
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }];
    [self.zhangwoBtn setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateNormal];
    [self.lianxiBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
}
//获取网络数据
-(void)getJson:(NSString *)http type:(NSString *)type{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:http parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        //NSLog(@"%lld",downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([type isEqualToString:@"lianxiDic"]){
            if([responseObject[@"ecode"] isEqualToString:@"0"]){
                self.lianxiDic = responseObject;
                //因为是子线程获取的数据。必须刷新视图
                [self.lianxiTableView reloadData];
            }
        }else if([type isEqualToString:@"zhangwoDic"]){
            if([responseObject[@"ecode"] isEqualToString:@"0"]){
                self.zhangwoDic = responseObject;
                [self.zhangwoTableView reloadData];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    
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
    return 2;
}
//实现tableView的必要方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 3;
    if(tableView.tag == 100){
    if (section == 0) {
        return [self.lianxiDic[@"edata"][@"part1"] count];
    }else if(section == 1){
        return [self.lianxiDic[@"edata"][@"part2_3"] count];
    }else{
        return 0;
    }
    }else{
        if (section == 0) {
            return [self.zhangwoDic[@"edata"][@"part1"] count];
        }else if(section == 1){
            return [self.zhangwoDic[@"edata"][@"part2_3"] count];
        }else{
            return 0;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StudyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[StudyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    UIColor *btnStateNormalTitleColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    if (tableView.tag == 100) {
        
        [self.zhangwoBtn setTitleColor:btnStateNormalTitleColor forState:UIControlStateNormal];
        [self.lianxiBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (indexPath.section == 0) {
            cell.dic = self.lianxiDic[@"edata"][@"part1"][indexPath.row];
        }else if(indexPath.section == 1){
            cell.dic = self.lianxiDic[@"edata"][@"part2_3"][indexPath.row];
        }
    }else if(tableView.tag == 101){
        [self.lianxiBtn setTitleColor:btnStateNormalTitleColor forState:UIControlStateNormal];
        [self.zhangwoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (indexPath.section == 0) {
            cell.dic = self.zhangwoDic[@"edata"][@"part1"][indexPath.row];
        }else if(indexPath.section == 1){
            cell.dic = self.zhangwoDic[@"edata"][@"part2_3"][indexPath.row];
        }
    }
    [cell createCell];

    if(indexPath.row % 2 == 0){
        cell.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    }
    
    
    return cell;
}
//自定义titleHeader
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    customView.backgroundColor = [UIColor whiteColor];
    if(section == 0){
        NSString *string = @"PART1";
        CGFloat strWidth = [self getStringWidth:string strFont:kTitleStrFont returnWidth:YES returnHeight:NO];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth/2) - (strWidth/2), 0, strWidth, 40)];
        textLabel.font = kTitleStrFont;
        textLabel.text = string;
        [customView addSubview:textLabel];
    }else if(section == 1){
        NSString *string = @"PART2 & 3";
        CGFloat strWidth = [self getStringWidth:string strFont:kTitleStrFont returnWidth:YES returnHeight:YES];
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth/2) - (strWidth/2),0, strWidth, 40)];
        textLabel.font = kTitleStrFont;
        textLabel.text = string;
        [customView addSubview:textLabel];
    }
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
/**
 *  获取字符串宽度或高度
 *
 *  @param string       要获取宽度的字符串
 *  @param fontSize     字符串的字体大小
 *
 *  @return 字符串的宽度或高度
 */
-(CGFloat)getStringWidth:(NSString *)string strFont:(UIFont *)strFont returnWidth:(BOOL)returnWidth returnHeight:(BOOL)returnHeight
{
//    CGSize sizeToFit = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, stringHeight) lineBreakMode:NSLineBreakByWordWrapping];
//    return sizeToFit.width;
    
    CGSize strSize = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
    if (returnWidth == YES) {
        return strSize.width;
    }else if (returnHeight == YES) {
        return strSize.height;
    }else{
        return 0;
    }
}

#pragma make --scrollView代理方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //获取当前页码
    self.currentPage = (targetContentOffset->x) / self.view.frame.size.width + 1;
    if (self.currentPage < 2) {
        [self.lianxiBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
        [self.zhangwoBtn setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateNormal];
    }else{
        [self.zhangwoBtn setTitleColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
        [self.lianxiBtn setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateNormal];
    }
}
@end
