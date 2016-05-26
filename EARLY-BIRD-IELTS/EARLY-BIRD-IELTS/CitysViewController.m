//
//  CitysViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/5/10.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CitysViewController.h"
#import "SchoolTableViewController.h"
#import "AFNetworking.h"
#import "UIView+Extension.h"
@interface CitysViewController ()
@property(nonatomic, strong)NSArray *allCitys;  //存储所有城市
@property(nonatomic, strong)NSMutableArray *allCitysBtn;  //存储所有城市按钮
@property(nonatomic, strong)NSString *cityName;
@end

@implementation CitysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self getNetWorkingJSON:@"http://testapp.benniaoyasi.com/api.php?m=api&c=Nbbs&a=listcitys&appid=1&devtype=ios&version=1.0&device=iPhoneSimulator&mobile=(null)&uuid=KY-4FF53302-484A-4B7E-BC5D-CF744BEADE92"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 自定义方法
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getNetWorkingJSON:(NSString *)url{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *ecode = [NSString stringWithFormat:@"%@",responseObject[@"ecode"]];
        if([ecode isEqualToString:@"1"]){
            [self createCitysList:responseObject[@"edata"]];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)createCitysList:(NSArray *)citys{
    self.allCitys = citys;
    //创建数组存放所有按钮宽度
    NSMutableArray *btnWidthArray = [NSMutableArray array];
    //循环数组，计算出按钮的宽度加入btnWidthArray中
    for(int i = 0; i<citys.count;i++){
        UIFont *strFont = [UIFont fontWithName:@"Arial" size:14];
        float strWidth = [citys[i] boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size.width;
        [btnWidthArray addObject:[NSString stringWithFormat:@"%f",strWidth+12]];
    }
    //初始化行计数器
    NSInteger line = 0;
    //列
    NSInteger list = 0;
    //记录button x的坐标位置,起始位置为15
    NSInteger linX = 15;
    //记录宽度，换行
    NSInteger widthLine = 0;
    for(int i=0;i<btnWidthArray.count;i++){
        //累计X值
        float tempTextWidth;
        //累计宽度
        float textTempWidth;
        if(i >= 1){
            tempTextWidth = [btnWidthArray[i-1] floatValue];
        }else{
            tempTextWidth = 0;
        }
        linX += tempTextWidth+5;
        widthLine += (textTempWidth+10);
        
        if(widthLine > self.view.width-30){
            list += 1;
            linX = 15;
            line = i;
            widthLine = textTempWidth;
        }
        if(i==0 || line == i){
            linX = 15;
        }
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(linX, 64+list*(30+5), [btnWidthArray[i] floatValue], 30)];
        [btn setTitle:citys[i] forState:UIControlStateNormal];
        btn.layer.borderWidth = .5;
        btn.layer.borderColor = [[UIColor blueColor]CGColor];
        btn.layer.cornerRadius = 15;
        
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor purpleColor];
        [btn addTarget:self action:@selector(cityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 200+i;
        [self.allCitysBtn addObject:btn];
        [self.view addSubview:btn];
    }
}

-(void)cityBtnClick:(UIButton *)sender{
   // SchoolTableViewController *schoolView = (SchoolTableViewController *)[self.navigationController.viewControllers objectAtIndex:0];
    for(int i = 0; i<self.allCitys.count; i++){
        if(sender.tag == 200+i){
           // schoolView.paramCity = self.allCitys[i];
            self.cityName = self.allCitys[i];
            
            
        }
    }
    
    //此页面已经存在于self.navigationController.viewControllers中,并且是当前页面的前一页面
    SchoolTableViewController *schoolView = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-2];
    //初始化其属性
    schoolView.paramCity = nil;
    //传递参数过去
    schoolView.paramCity = self.cityName;
    //使用popToViewController返回并传值到上一页面
    [self.navigationController popToViewController:schoolView animated:true];
}


@end
