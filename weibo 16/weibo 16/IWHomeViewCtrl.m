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
#import "IWAccountTool.h"
#import "IWAcount.h"
#import "AFNetWorking.h"
#import "IWUser.h"
#import "MJExtension.h"
#import "IWStatus.h"
#import "UIViewController+ESSeparatorInset.h"
#import "IWLoadMoreView.h"
#import "IWUnReadCount.h"
#import <objc/runtime.h>
#import "IWStatusCell.h"
#import "IWStatusFrame.h"
//默认加载条数
#define LOAD_COUNT 20

@interface IWHomeViewCtrl ()
@property(nonatomic, strong)NSMutableArray *statusFrames;
@property(nonatomic, assign)BOOL isLoadMore;
@end

@implementation IWHomeViewCtrl
-(NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //隐藏CELL的分割线
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.backgroundColor = RGB(240, 240, 240);
    [self.tableView registerClass:[IWStatusCell class] forCellReuseIdentifier:identifier];

    
    [self setSeparatorInsetZeroWithTableView:self.tableView];
    
    
    
    [self setupNav];
    [self setRefreshView];
    
    //获取个人信息
    [self getUserInfo];
    
    
    //[self temp];
    
//    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(loadUnReadCount) userInfo:nil repeats:YES];
//    //让time立刻执行
//    [time fire];
//    NSRunLoop *runLoop = [NSRunLoop mainRunLoop];
//    [runLoop addTimer:time forMode:NSRunLoopCommonModes];
    
}
-(void)setRefreshView{
    //刷新控件
    UIRefreshControl *refreshCtrl = [[UIRefreshControl alloc] init];
    //给刷新控件添加值改变的监听事件
    [refreshCtrl addTarget:self action:@selector(loadNewStatues:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refreshCtrl];
    [refreshCtrl beginRefreshing];
    //加载最近的数据
    [self loadNewStatues:refreshCtrl];
    //设置加载更多的view
    IWLoadMoreView *loadMoreView = [IWLoadMoreView loadMoreView];
    loadMoreView.hidden = YES;
    self.tableView.tableFooterView = loadMoreView;
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
- (void)temp{
    for (UIView *tabBarChild in self.tabBarController.tabBar.subviews) {
        if ([tabBarChild isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *tabBarButtonChild in tabBarChild.subviews) {
                if ([tabBarButtonChild isKindOfClass:NSClassFromString(@"_UIBadgeView")]) {
                    for (UIView * badgeViewChild in tabBarButtonChild.subviews) {
                        if ([badgeViewChild isKindOfClass:NSClassFromString(@"_UIBadgeBackground")]) {
                            NSLog(@"终于找到你，还好没放弃");
                            NSLog(@"%@",badgeViewChild);
                            //                            badgeViewChild.backgroundColor = [UIColor blackColor];
                            //虽然找到了，不知道设置其身上什么值去更改那个大红色
                            //有没有相关的方法去获取其身上的属性再看看
                            
                            
                            
                            
                            unsigned int count;
                            //获取某个类身上的所有属性
                            Ivar *ivars = class_copyIvarList([badgeViewChild class], &count);
                            
                            for (int i = 0; i < count; i++) {
                                Ivar ivar = ivars[i];
                                
                                //获取属性的名字
                                NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
                                //获取属性的类型
                                NSString *ivarType = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
                                
                                NSLog(@"%@:%@",ivarName,ivarType);
                                //判断如果当前是_image属性
                                if ([ivarName isEqualToString:@"_image"]) {
                                    
                                    UIImage *image = [UIImage imageNamed:@"main_badge"];
                                    //通过kvc去设置某个对象身上的某个属性的值
                                    [badgeViewChild setValue:image forKeyPath:@"image"];
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarItem.badgeValue = nil;
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IWStatusCell *cell = [IWStatusCell cellWithTableView:tableView];
    IWStatusFrame *frame = self.statusFrames[indexPath.row];
    [cell setStatusFrame:frame];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tabBarItem.badgeValue = @"15";
    //[self temp];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.statusFrames[indexPath.row] cellHeight];
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self setSeparatorInsetWithTarget:cell insets:UIEdgeInsetsZero];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //监听滑动到底部
    //tableView的内容高度-屏幕高度 <= scrollView的滑动距离
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.hidden==NO) {
        return ;
    }
    CGFloat result = scrollView.contentSize.height - SCREENH;
    if (result <= scrollView.contentOffset.y - self.tabBarController.tabBar.height) {
        NSLog(@"滑动到底部");
//        if (!self.isLoadMore == NO) {
//            self.isLoadMore = YES;
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int16_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self loadMoreStatues];
//            });
//        }

            //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int16_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self loadMoreStatues];
            //});
        
        
    }
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
//加载更早的微博
-(void)loadMoreStatues{
    NSString *urlStr = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    IWAcount *account = [IWAccountTool account];
    //拼装参数
    params[@"access_token"] = account.access_token;
    params[@"count"] = @(LOAD_COUNT);
    if ([self.statusFrames lastObject]) {
        IWStatusFrame *frame = [self.statusFrames lastObject];
        params [@"max_id"] = @([frame.status id] - 1);
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.tableView.tableFooterView.hidden = YES;
        //这里面存的是返回的字典
        NSArray *statusesDic = responseObject[@"statuses"];
        //使用第三方框架字典转模型
        NSArray *statuses = [IWStatus objectArrayWithKeyValuesArray:statusesDic];
        
        NSArray *statuesFrames = [self converToFrameWithStatues:statuses];
        //初始化一个范围
        //NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        [self.statusFrames addObjectsFromArray:statuesFrames];
        //self.statusArray = statuses;
        [self.tableView reloadData];
         //self.isLoadMore = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.tableView.tableFooterView.hidden = YES;
         //self.isLoadMore = NO;
    }];
}
//获取个人用户信息
-(void)getUserInfo{
    NSString *urlStr = @"https://api.weibo.com/2/users/show.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    IWAcount *account = [IWAccountTool account];
    //拼装参数
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        IWUser *user = [[IWUser alloc]init];
        //第三方框架，字典转模型
        [user setKeyValues:responseObject];
        IWHomeTitleButton *button = (IWHomeTitleButton *)self.navigationItem.titleView;
        [button setTitle:user.screen_name forState:UIControlStateNormal];
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败%@",error);
    }];
}
//获取首页的微博信息
-(void)loadNewStatues:(UIRefreshControl *)refreshControl{
    NSString *urlStr = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    IWAcount *account = [IWAccountTool account];
    //拼装参数
    params[@"access_token"] = account.access_token;
    params[@"count"] = @(LOAD_COUNT);
    if ([self.statusFrames firstObject]) {
        IWStatusFrame *frame = [self.statusFrames firstObject];
        params [@"since_id"] = @(frame.status.id);
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.tabBarItem.badgeValue = nil;
        [refreshControl endRefreshing];
        //这里面存的是返回的字典
        NSArray *statusesDic = responseObject[@"statuses"];
        //使用第三方框架字典转模型
        NSArray *statuses = [IWStatus objectArrayWithKeyValuesArray:statusesDic];
        NSArray *statuesFrames = [self converToFrameWithStatues:statuses];
        //初始化一个范围
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, statuses.count)];
        [self.statusFrames insertObjects:statuesFrames atIndexes:set];
        //self.statusArray = statuses;
        [self.tableView reloadData];
        //显示加载条数
        [self showLoadCountLabelWithCount:statuses.count];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        [refreshControl endRefreshing];
    }];
}
//把模型转换成Frame
-(NSArray *)converToFrameWithStatues:(NSArray *)statues{
    NSMutableArray *statusArray = [NSMutableArray array];
    for (IWStatus *status in statues) {
        IWStatusFrame *frame = [[IWStatusFrame alloc] init];
        frame.status = status;
        [statusArray addObject:frame];
    }
    return [statusArray copy];
}

//获取首页的微博信息
-(void)loadUnReadCount{
    NSString *urlStr = @"https://api.weibo.com/2/remind/unread_count.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    IWAcount *account = [IWAccountTool account];
    //拼装参数
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        IWUnReadCount *unReadCount = [[IWUnReadCount alloc]init];
        [unReadCount setKeyValues:responseObject];
        if (unReadCount.status) {
            self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",unReadCount.status];
            //设置应用图标上的提示数字
            [UIApplication sharedApplication].applicationIconBadgeNumber = unReadCount.status;
        }else{
            self.tabBarItem.badgeValue = nil;
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
}
//有数据就显示动画提示
-(void)showLoadCountLabelWithCount:(NSInteger)count{
    //根据返回的数据
    UILabel *textLabel = [[UILabel alloc]init];
    
    NSString *string = @"没有最新微博数据";
    if (count) {
        string = [NSString stringWithFormat:@"共加载出%zd条数据",count];
    }
    
    
    textLabel.text = string;
    textLabel.backgroundColor = [UIColor orangeColor];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = SYS_FONT(15);
    textLabel.size = CGSizeMake(SCREENW, 35);
    textLabel.y = 64 - textLabel.height;
    //文字居中
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.navigationController.view insertSubview:textLabel belowSubview:self.navigationController.navigationBar];
    //动画移动一个Label,改变Label的y值或x值,效果，Label向下移动显示后再自动回去消失
    [UIView animateWithDuration:1 animations:^{
        //改变Label的高度
        textLabel.transform = CGAffineTransformMakeTranslation(0, textLabel.height);
    } completion:^(BOOL finished) {
        //再执行消失动画
        [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionLayoutSubviews animations:^{
            //改变高度
            //textLabel.y = 64 - textLabel.height;
            //回到最初状态
            textLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            //Lable隐藏
            textLabel.hidden = YES;
            //移除Label
            [textLabel removeFromSuperview];
        }];
    }];
}
@end
