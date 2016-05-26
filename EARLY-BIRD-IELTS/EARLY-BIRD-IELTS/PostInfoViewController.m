//
//  PostInfoViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/5/25.
//  Copyright © 2016年 何建新. All rights reserved.
//
/*
 http://testapp.benniaoyasi.com/api.php?appid=1&m=api&c=Nbbs&a=infoBbs&id=84&devtype=ios&version=4.0&device=iphone5s&mobile=18610905643&uuid=01775B6A-D165-4CBE-8690-7FDA7DE875FE&uid=1005
 */

#import "PostInfoViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "SDWebImage/UIImageView+WebCache.h"
@interface PostInfoViewController ()
@property(nonatomic, copy)NSMutableDictionary *postInfoDic;
@end

@implementation PostInfoViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSString *url = [NSString stringWithFormat:@"http://testapp.benniaoyasi.com/api.php?appid=1&m=api&c=Nbbs&a=infoBbs&id=%@&devtype=ios&version=4.0&device=iphone5s&mobile=18600562546&uuid=01775B6A-D165-4CBE-8690-7FDA7DE875FE&uid=1005",self.postId];
    [self getNetWorkingJSON:url];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(share)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    self.navigationItem.rightBarButtonItem = rightBtn;
    NSLog(@"%@",self.postId);
    
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
#pragma mark ---自定义方法
//获取网络数据
-(void)getNetWorkingJSON:(NSString *)url{
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if([responseObject[@"ecode"] isEqualToString:@"0"]){
            self.postInfoDic = responseObject[@"edata"];
            //拿到数据后调用创建view的方法
            [self createPostInfoView:self.postInfoDic];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
//创建页面
-(void)createPostInfoView:(NSMutableDictionary *)infoDic{
    NSLog(@"%@",infoDic);
    //创建学校view
    UIView *schoolView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 40)];
    UILabel *schoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, [UIScreen mainScreen].bounds.size.width - 30, 20)];
    schoolLabel.text = infoDic[@"school_name"];
    schoolView.backgroundColor = [UIColor redColor];
    [schoolView addSubview:schoolLabel];
    //头像与名称
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, schoolView.frame.origin.y+schoolView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 40)];
    headerView.backgroundColor = [UIColor blackColor];
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:infoDic[@"uimage"]]];
    [headerView addSubview:headerImageView];
    
    
    
    
    
    
    [self.view addSubview:schoolView];
    [self.view addSubview:headerView];
}
//返回
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
//分享
-(void)share{
    NSLog(@"分享按钮");
}
@end
