//
//  IntelligenceViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/28.
//  Copyright © 2016年 何建新. All rights reserved.
//
/*
 帖子列表
 http://testapp.benniaoyasi.com/api.php?m=api&c=Nbbs&a=listBbs&appid=1&school_id=1&devtype=ios&version=1.0.1&device=iphone5s&mobile=18610905643&uuid=01775B6A-D165-4CBE-8690-7FDA7DE875FE
 */

#import "IntelligenceViewController.h"
#import "SchoolListTableViewCell.h"  //自定时cell
#import "AFNetworking/AFNetworking.h"
#import "SchoolTableViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "PostInfoViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define strFont [UIFont fontWithName:@"Arial" size:14]
#define kFont [UIFont fontWithName:@"Arial" size:14]
@interface IntelligenceViewController ()
//主滑动视图
@property(nonatomic, strong)UIScrollView *scrollView;
//banner滚动视图
@property(nonatomic, strong)UIScrollView *bannerScrollView;
//推荐课程视图
@property(nonatomic, strong)UIView *courseView;
//学校schoolView
@property(nonatomic, strong)UIView *schoolView;

//学校tableView
@property(nonatomic, strong)UITableView *tableView;
//推荐学校下帖子
@property(nonatomic, strong)NSMutableDictionary *PostingsDic;
@property(nonatomic, strong)NSMutableArray *postingsArray;

@end

@implementation IntelligenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *url = @"http://testapp.benniaoyasi.com/api.php?m=api&c=Nbbs&a=listBbs&appid=1&school_id=1&devtype=ios&version=1.0.1&device=iphone5s&mobile=18610905643&uuid=01775B6A-D165-4CBE-8690-7FDA7DE875FE";
    [self getNetWorkingJSON:url];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    //隐藏导航栏背景图和边框
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
    self.scrollView.scrollEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.tag = 200;
    [self.view addSubview:self.scrollView];
    /* ---------------bannerScrollView start-------------------- */
    [self createBannerView];
    /* ---------------推荐课程 start-------------------- */
    //推荐课程View
    [self createCourseView];
    /* -----------底部cell------------ */
    [self createSchoolTableView];
    
    //计算scrollView的Size
    self.scrollView.contentSize = CGSizeMake(0, self.bannerScrollView.frame.size.height+self.courseView.frame.size.height+self.schoolView.frame.size.height-60);
    self.scrollView.backgroundColor = [UIColor redColor];
    
}
#pragma mark ----  自定义方法
//学校帖子tableView
-(void)createSchoolTableView{
    float y = self.bannerScrollView.frame.size.height+self.courseView.frame.size.height - 64;
    //header
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    headerView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //为您推荐Label
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 23, 150, 60)];
    label1.font = strFont;
    label1.text = @"为您推荐：北京语言大学";
    [label1 sizeToFit];
    [headerView addSubview:label1];
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-40, 23, 80, 60)];
//    label2.font = strFont;
//    label2.text = @"全部";
    UIButton *allSchoolBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-40, 18, 80, 60)];
    allSchoolBtn.font = strFont;
    [allSchoolBtn setTitle:@"全部" forState:UIControlStateNormal];
    [allSchoolBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [allSchoolBtn sizeToFit];
    [allSchoolBtn addTarget:self action:@selector(allSchoolBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:allSchoolBtn];
    //tableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.bounces = NO;
    self.scrollView.contentSize = CGSizeMake(0, kScreenHeight);
    //schoolView
    self.schoolView = [[UIView alloc] initWithFrame:CGRectMake(0, y, kScreenWidth, headerView.frame.size.height+self.tableView.frame.size.height)];
    [self.schoolView addSubview:headerView];
    [self.schoolView addSubview:self.tableView];
    
    [self.scrollView addSubview:self.schoolView];
    
    
}
//点击为您推荐的全部按钮的方法
-(void)allSchoolBtnClick{
    SchoolTableViewController *schoolTableView = [[SchoolTableViewController alloc] init];
    schoolTableView.title = @"全部";
    [self.navigationController pushViewController:schoolTableView animated:YES];
}
//推荐课程View
-(void)createCourseView{
    self.courseView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bannerScrollView.frame.origin.y+120, kScreenWidth, 160)];
    //推荐课程titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    [self.courseView addSubview:titleView];
    //titleLabel
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 60, 60)];
    titleLabel.font = strFont;
    titleLabel.text = @"推荐课程";
    [titleView addSubview:titleLabel];
    UILabel *allLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth-40, 0, 30, 60)];
    allLabel.font = strFont;
    allLabel.text = @"全部";
    [titleView addSubview:allLabel];
    //课程图片列表ScrollView
    UIScrollView *courseScrollView = [[UIScrollView alloc] init];
    courseScrollView.pagingEnabled = YES;
    courseScrollView.showsHorizontalScrollIndicator = FALSE;
    float x = 0;
    for (int i = 0; i<5; i++) {
        if(i != 0){
            x += 110;
        }
        
        UIImageView *courseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, 100, 100)];
        courseImageView.backgroundColor = [UIColor grayColor];
        [courseScrollView addSubview:courseImageView];
    }
    [courseScrollView setFrame:CGRectMake(0, 60, x, 100)];
    courseScrollView.contentSize = CGSizeMake(x + 300, 0);
    [self.courseView addSubview:courseScrollView];
    [self.scrollView addSubview:self.courseView];
}
//banner动态广告
-(void)createBannerView{
    self.bannerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -64, kScreenWidth, 120)];
    self.bannerScrollView.pagingEnabled = YES;
    self.bannerScrollView.showsHorizontalScrollIndicator = NO;
    //虚拟3个页面
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    view1.backgroundColor = [UIColor brownColor];
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, 120)];
    view2.backgroundColor = [UIColor orangeColor];
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*2, 0, kScreenWidth, 120)];
    view3.backgroundColor = [UIColor whiteColor];
    self.bannerScrollView.contentSize = CGSizeMake(kScreenWidth*3, 0);
    [self.bannerScrollView addSubview:view1];
    [self.bannerScrollView addSubview:view2];
    [self.bannerScrollView addSubview:view3];
    [self.scrollView addSubview:self.bannerScrollView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goBack{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
//获取网络JSON

-(void)getNetWorkingJSON:(NSString *)url{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"ecode"] isEqualToString:@"0"]){
            //self.PostingsDic = responseObject[@"edata"];
            self.postingsArray = responseObject[@"edata"];
//            NSMutableArray *mArray = [NSMutableArray array];
//            for (NSDictionary *d in responseObject[@"edata"]) {
//                [mArray addObject:d];
//                NSLog(@"%@",d);
//            }
            //self.postingsArray = mArray;
            
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark -- tableView方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.postingsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SchoolListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[SchoolListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    cell.infoDic = self.postingsArray[indexPath.row];
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *infoDic = self.postingsArray[indexPath.row];
    //头像
    UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    //headImageView.image = [UIImage];
    if(infoDic[@"uimage"] != nil){
        [headImageView sd_setImageWithURL:[NSURL URLWithString:infoDic[@"uimage"]]];
    }
    //名称Size
    CGSize nameSize = [self stringSize:infoDic[@"uname"]];
    //名称
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, nameSize.width, 20)];
    nameLabel.font = kFont;
    nameLabel.text = infoDic[@"uname"];
    nameLabel.textColor = [UIColor blueColor];
    //大学
    CGSize schoolNameSize = [self stringSize:infoDic[@"school_name"]];
    UILabel *schoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, schoolNameSize.width, 20)];
    schoolLabel.font = kFont;
    schoolLabel.text = infoDic[@"school_name"];
    //发帖时间
    CGSize createTimeSize = [self stringSize:infoDic[@"create_time_geshi"]];
    //    UILabel *createTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - createTimeSize.width - 10, 20 - (createTimeSize.height / 2), createTimeSize.width, createTimeSize.height)];
    UILabel *createTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - createTimeSize.width - 10, 20, createTimeSize.width, createTimeSize.height)];
    createTimeLabel.font = kFont;
    createTimeLabel.textColor = [UIColor grayColor];
    createTimeLabel.text = infoDic[@"create_time_geshi"];
    //帖子内容
    CGSize contentSize = [self stringSize:infoDic[@"content"]];
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, headImageView.frame.size.height + headImageView.frame.origin.y + 5, [UIScreen mainScreen].bounds.size.width - 10, contentSize.height)];
    contentLabel.numberOfLines = 0;
    contentLabel.font = kFont;
    contentLabel.text = infoDic[@"content"];
    
    CGFloat imgAllViewHeight = 0.0;
    UIView *imageAllView = [[UIView alloc] init];
    if([infoDic[@"images"] count] > 1 && [infoDic[@"images"] count] < 3){
        for(int i = 0; i<[infoDic[@"images"] count]; i++){
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*100 + 5, 0, 100, 100)];
            [imgView sd_setImageWithURL:infoDic[@"images"][i][@"middle_image"]];
            [imageAllView addSubview:imgView];
        }
        imgAllViewHeight = 100;
    }else if([infoDic[@"images"] count] > 3){
        for(int i = 0; i<3; i++){
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*100 + 5, 0, 100, 100)];
            [imgView sd_setImageWithURL:infoDic[@"images"][i][@"middle_image"]];
            [imageAllView addSubview:imgView];
        }
        int a = 0;
        for(int j = 3; j<6; j++){
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(a*100 + 5, 105, 100, 100)];
            [imgView sd_setImageWithURL:infoDic[@"images"][j-1][@"middle_image"]];
            [imageAllView addSubview:imgView];
            a++;
        }
        imgAllViewHeight = 205;
    }
    
    [imageAllView setFrame:CGRectMake(0, contentLabel.frame.origin.y+contentLabel.frame.size.height+10, [UIScreen mainScreen].bounds.size.width, imgAllViewHeight)];
    imageAllView.backgroundColor = [UIColor blackColor];
    
    //栏目、点赞、回帖按钮view
    UIView *favorView = [[UIView alloc] initWithFrame:CGRectMake(0, imageAllView.frame.origin.y+imageAllView.frame.size.height+5, [UIScreen mainScreen].bounds.size.width, 20)];
    //CGFloat cellHeight = (contentLabel.frame.origin.y + contentLabel.frame.size.height) + 25 + (imgAllViewHeight) + favorView.frame.size.height;
    CGFloat cellHeight = headImageView.frame.size.height + contentLabel.frame.size.height + imageAllView.frame.size.height + favorView.frame.size.height + 25;
    return cellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostInfoViewController *postView = [[PostInfoViewController alloc] init];
    NSMutableDictionary *infoDic = self.postingsArray[indexPath.row];
    postView.postId = infoDic[@"id"];
    [self.navigationController pushViewController:postView animated:YES];
}
// 计算文字内容高度
-(CGSize)stringSize:(NSString *)string{
    
    CGSize strSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:kFont} context:nil].size;
    return strSize;
}
#pragma mark ---- scrollView代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.tag == 200){
        if(self.scrollView.contentOffset.y >= 216){
            self.tableView.scrollEnabled = YES;
        }else{
            self.tableView.scrollEnabled = NO;
        }
    }
}
@end
