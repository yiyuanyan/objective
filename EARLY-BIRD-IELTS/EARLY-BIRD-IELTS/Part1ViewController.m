//
//  Part1ViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/22.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "Part1ViewController.h"
#import "MBProgressHUD.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define strFont [UIFont fontWithName:@"Arial" size:14]
@interface Part1ViewController ()
@property(nonatomic, strong)NSMutableDictionary *allCategoryDic;
@property(nonatomic, strong)NSMutableDictionary *tableList;
@property(nonatomic, strong)NSMutableArray *listArray;
@property(nonatomic, strong)NSMutableArray *allArray;
@property(nonatomic, strong)NSMutableDictionary *allDic;

@property(nonatomic, strong)NSMutableArray *allBtn;
@end

@implementation Part1ViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.listArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.allArray = [[NSMutableArray alloc] initWithCapacity:0];
    self.allDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    self.allBtn = [[NSMutableArray alloc] initWithCapacity:0];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    //隐藏导航栏背景图和边框
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    [self getNetWorking:@"http://testapp.benniaoyasi.com/api.php?appid=1&m=api&c=Ncategory&a=listcategory&pid=1&devtype=android&version=2.0" type:@"allCategory" tableViewX:0];
    self.topScrollView.showsHorizontalScrollIndicator = FALSE;
    self.topScrollView.pagingEnabled = YES;
    self.tableScrollView.pagingEnabled = YES;
    self.tableScrollView.delegate = self;
    
    //self.tableScrollView.backgroundColor = [UIColor blueColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma makr --自定义方法
-(void)createTableList:(NSMutableDictionary *)cateDic listDic:(NSMutableDictionary *)listDic tableViewX:(float)tableViewX{
    
    UITableView *listTableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, -64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    
    listTableView.delegate = self;
    listTableView.dataSource = self;
    listTableView.tag = (tableViewX/kScreenWidth) + 101;
    NSString *key = [NSString stringWithFormat:@"%d",listTableView.tag];
    [self.allDic setObject:listDic forKey:key];
    //self.allArray[@"tag"] = [NSString stringWithFormat:@"%d",listTableView.tag];
    //self.allArray
    self.tableList = listDic;
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *d in listDic) {
        
        [mArray addObject:d];
    }
    self.listArray = mArray;
   [self.allArray addObject:mArray];
    [self.tableScrollView addSubview:listTableView];
    CGSize scrollViewW = CGSizeMake(tableViewX+kScreenWidth, kScreenWidth);
    self.tableScrollView.contentSize = scrollViewW;
}
-(void)createTopCategory:(NSMutableDictionary *)dic{
    int i = 0;
    float btnX = 0;
    float allBtnX = 0;
    for (NSDictionary *d in dic) {
        //按钮标题size
        CGSize btnSize = [self getStringSize:d[@"ename"]];
        if(i == 0){
            btnX = 10;
        }else{
            btnX = allBtnX+(10*(i+1));
        }
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, 0, btnSize.width, 30)];
        [btn setTitle:d[@"ename"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateNormal];
        btn.tag = 200 + i;
        if(btn.tag == 200){
            
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        btn.font = strFont;
        [btn addTarget:self action:@selector(clickTopBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.allBtn addObject:btn];
        [self.topScrollView addSubview:btn];
        NSString *url = [NSString stringWithFormat:@"http://testapp.benniaoyasi.com/api.php?appid=1&m=api&c=ncategory&a=listcategory&devtype=android&version=2.0&uuid=123&leval=%@",d[@"evalue"]];
        float tableViewX = kScreenWidth * i;
        [self getNetWorking:url type:@"tableList" tableViewX:tableViewX];
        allBtnX += btnSize.width;
        i++;
        
    }
    self.topScrollView.contentSize = CGSizeMake(allBtnX+150, 0);
}
//点击top的按钮
-(void)clickTopBtn:(UIButton *)sender{
    
    NSLog(@"%@",self.allBtn);
    for (int i = 0; i<self.allBtn.count; i++) {
        NSLog(@"%d",[[self.allBtn objectAtIndex:i] tag]);
        if([[self.allBtn objectAtIndex:i] tag] == sender.tag){
            [[self.allBtn objectAtIndex:i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            NSInteger x = sender.tag - 200;
            NSLog(@"%f",kScreenWidth*x);
            [self.tableScrollView setContentOffset:CGPointMake(kScreenWidth * x, -64) animated:YES];
        }else{
            [[self.allBtn objectAtIndex:i] setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateNormal];
            
            
        }
    }
}
//计算字符串size
-(CGSize)getStringSize:(NSString *)string{
    CGSize strSize = [string boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
    return strSize;
}
-(void)goBack{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSMutableDictionary *)getNetWorking:(NSString *)url type:(NSString *)type tableViewX:(float)tableViewX{
    
    NSURL *http = [NSURL URLWithString:url];
    NSURLRequest *quest = [NSURLRequest requestWithURL:http cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [NSURLConnection sendAsynchronousRequest:quest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(!connectionError){
            //将response转换成NSHTTPURLResponse类型
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            //判断返回来的状态吗
            if(httpResponse.statusCode == 200){
                //解析JSON，转换字典
                NSError *error = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                
                if(!error){
                    if([type isEqualToString:@"allCategory"]){
                        //[self createTopCategory:json[@"edata"]];
                        self.allCategoryDic = json[@"edata"];
                        [self performSelectorOnMainThread:@selector(createTopCategory:) withObject:json[@"edata"] waitUntilDone:YES];
                    }else{
                        NSLog(@"%@",url);
                        [self createTableList:self.allCategoryDic listDic:json[@"edata"] tableViewX:tableViewX];
                    }
                    
                }else{
                    NSLog(@"解析失败");
                }
            }else{
                NSLog(@"服务器状态不可用,%d-------%@",httpResponse.statusCode,url);
            }
        }else{
            NSLog(@"请求连接失败");
        }
    }];
    return nil;
}
//提示信息
-(void)MBProgressHUD:(NSString *)message{

}

#pragma mark - TableView方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.listArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    NSString *str = [NSString stringWithFormat:@"%d",tableView.tag];
    NSLog(@"%@",self.allDic[str][indexPath.row][@"chinese"]);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.allDic[str][indexPath.row][@"chinese"];
    return cell;
}
#pragma mark - ScrollView方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取当前视图的宽度
    CGFloat pageWith = scrollView.frame.size.width;
    //根据scrolView的左右滑动,对pageCotrol的当前指示器进行切换(设置currentPage)
    int page = floor((scrollView.contentOffset.x - pageWith/2)/pageWith)+1;
    for (int i = 0; i<self.allBtn.count; i++) {
        if([[self.allBtn objectAtIndex:i] tag] == (page + 200)){
            [[self.allBtn objectAtIndex:i] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            [[self.allBtn objectAtIndex:i] setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateNormal];
        }
    }
    
}
@end
