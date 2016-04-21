//
//  Part1ViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/21.
//  Copyright © 2016年 何建新. All rights reserved.
//
/*
 allCategory
 http://testapp.benniaoyasi.com/api.php?appid=1&m=api&c=Ncategory&a=listcategory&pid=1&devtype=android&version=2.0
 */
/*
 categoryList
 http://test.benniaoyasi.cn/api.php?appid=1&m=api&c=category&a=listcategory&devtype=android&version=2.0&uuid=123&leval=PersonalInformation
 */

#import "Part1ViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kStrFont [UIFont fontWithName:@"Arial" size:14]
#define kTitleStrFont [UIFont fontWithName:@"Arial" size:18]
@interface Part1ViewController ()
@property(nonatomic, strong)MBProgressHUD *hud;
@property(nonatomic, strong)NSMutableDictionary *allCategoryDic;
@property(nonatomic, strong)NSMutableArray *categoryListArr;
@property(nonatomic, strong)NSString *param;
@end

@implementation Part1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //去掉导航栏背景色和边框
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getNetWorkingJSON:@"http://testapp.benniaoyasi.com/api.php?appid=1&m=api&c=Ncategory&a=listcategory&pid=1&devtype=android&version=2.0" type:@"allCategory"];
    //NSString *url = [NSString stringWithFormat:@"http://test.benniaoyasi.cn/api.php?appid=1&m=api&c=category&a=listcategory&devtype=android&version=2.0&uuid=123&leval=%@",self.param];
    [self getNetWorkingJSON:@"http://test.benniaoyasi.cn/api.php?appid=1&m=api&c=category&a=listcategory&devtype=android&version=2.0&uuid=123&leval=PersonalInformation" type:@"categoryList"];
    
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.topScrollView.showsVerticalScrollIndicator = NO;
    self.topScrollView.showsHorizontalScrollIndicator = NO;
    
    
    
    
    
    
}
-(void)createTableView:(NSMutableArray *)array{
    for(int i = 0; i<array.count; i++){
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth*i, -64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
        tableView.tag = i;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.tableScrollView addSubview:tableView];
        //tableScrollView开始翻页
        self.tableScrollView.pagingEnabled = YES;
        self.tableScrollView.contentSize = CGSizeMake(kScreenWidth * array.count, 0);
        [tableView reloadData];
    }
}
-(void)createAllCategoryBtn:(NSMutableDictionary *)dic{
    
    float allBtnX = 0.0;
    float btnX = 0.0;
    int i = 0;
    NSLog(@"%@",dic);
    for (NSDictionary *d in dic) {
        CGSize strSize = [self stringCGSize:d[@"ename"] strFont:kStrFont];
        if(i == 0){
            btnX = 10;
            allBtnX += strSize.width+10;
        }else{
            allBtnX += strSize.width+10;
            btnX = allBtnX - strSize.width;
        }

        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, 0, strSize.width, 30)];
        btn.font = kStrFont;
        [btn setTitle:d[@"ename"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.topScrollView addSubview:btn];
        i++;
        self.topScrollView.contentSize = CGSizeMake(allBtnX + 100, 0);
    }
}
//返回字符串的CGSize
-(CGSize)stringCGSize:(NSString *)string strFont:(UIFont *)strFont{
    CGSize strSize = [string boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
    return strSize;
}
-(void)getNetWorkingJSON:(NSString *)url type:(NSString *)type{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置请求类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //开始请求数据
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //数据有返回值
        if([type isEqualToString:@"allCategory"]){
            if(self.allCategoryDic == nil){
                [self MBProgressShowMessage:@"正在请求网络"];
            }
            
            if([responseObject[@"ecode"] isEqualToString:@"0"]){
                self.allCategoryDic = responseObject[@"edata"];
                
                if(self.allCategoryDic != nil){
                    [self MBProgressHidMessage];
                }
            }else{
                [self MBProgressShowMessage:@"请求失败"];
            }
            [self createAllCategoryBtn:self.allCategoryDic];
            
        }else if([type isEqualToString:@"categoryList"]){
            if(self.categoryListArr == nil){
                [self MBProgressShowMessage:@"正在请求网络"];
            }
            NSLog(@"%@",responseObject);
            if([responseObject[@"ecode"] isEqualToString:@"0"]){
                NSMutableArray *mArray = [NSMutableArray array];
                for (NSDictionary *d in responseObject[@"edata"]) {
                    [mArray addObject:d];
                }
                self.categoryListArr = mArray;
            }else{
                [self MBProgressShowMessage:@"请求失败"];
            }
            [self createTableView:self.categoryListArr];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
-(void)MBProgressShowMessage:(NSString *)message{
    
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.labelText = message;
    self.hud.progress = 3;
    
}
-(void)MBProgressHidMessage{
    [self.hud hideAnimated:YES];
}
-(void)goBack{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryListArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text = @"asdfasdf";
    NSLog(@"%d",tableView.tag);
    return cell;
}

@end
