//
//  Part2ViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/27.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "Part2ViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define strFont [UIFont fontWithName:@"Arial" size:14]
@interface Part2ViewController ()
@property(nonatomic, strong)NSArray *topCategoryArray;  // 顶部导航栏数据
@property(nonatomic, strong)NSDictionary *topCategoryDic;
@property(nonatomic, strong)NSArray *tableArray;  //table数据
@property(nonatomic, strong)NSDictionary *tableDic;
@property(nonatomic, strong)NSMutableDictionary *allTableDic; //所有tableView数据字典
@property(nonatomic, strong)NSArray *allTopBtn;  //所有的top按钮
@end

@implementation Part2ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.allTableDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self getNetWorkingJSON:@"http://testapp.benniaoyasi.com/api.php?appid=1&m=api&c=ncategory&a=listcategory&pid=41&devtype=android&version=2.0" type:@"top" tableViewX:0.0];
    self.topScrollView.showsHorizontalScrollIndicator = FALSE;
    self.topScrollView.pagingEnabled = YES;
    self.tableScrollView.backgroundColor = [UIColor blueColor];
    self.tableScrollView.pagingEnabled = YES;
    self.tableScrollView.delegate = self;
    self.topScrollView.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark  自定义方法
-(void)goBack{
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)createTopBtn:(NSDictionary *)dic{
    int i = 0;
    float btnX = 0;
    float allBtnX = 0;
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *d in dic) {
        CGSize strSize = [self getStringSize:d[@"ename"]];
        UIColor *btnColor = [UIColor blackColor];
        if(i == 0){
            btnX = 10;
            
        }else{
            btnX = allBtnX+(10*(i+1));
            btnColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
        }
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, 0, strSize.width, 30)];
        btn.font = strFont;
        [btn setTitle:d[@"ename"] forState:UIControlStateNormal];
        [btn setTitleColor:btnColor forState:UIControlStateNormal];
        btn.tag = i + 200;
        [btn addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topScrollView addSubview:btn];
        //计算列表x值
        float tableViewX = kScreenWidth * i;
        //发送列表请求
        NSString *url = [NSString stringWithFormat:@"http://testapp.benniaoyasi.com/api.php?appid=1&m=api&c=ncontent&a=listcontent_part2_3&devtype=android&version=2.0&uuid=123&leval=%@&pageindex=1&pagenum=20",d[@"evalue"]];
        [self getNetWorkingJSON:url type:@"table" tableViewX:tableViewX];
        allBtnX += strSize.width;
        [mArray addObject:btn];
        i++;
    }
    self.allTopBtn = mArray;
    self.topScrollView.contentSize = CGSizeMake(allBtnX+150, 0);
    [self.topScrollView bringSubviewToFront:self.view];
}
/**
 *  创建tableView
 *
 *  @param dic        每个tableView的字典
 *  @param tableViewX 每个tableView的X值
 */
-(void)createTableView:(NSDictionary *)dic tableViewX:(float)tableViewX{
    UITableView *listTableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, -64, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    listTableView.delegate = self;
    listTableView.dataSource = self;
    //计算tableView的tag值
    listTableView.tag = (tableViewX/kScreenWidth) + 101;
    NSString *key = [NSString stringWithFormat:@"%d",listTableView.tag];
    //将tableView的字典加入全数据字典中，便于cell中使用
    [self.allTableDic setObject:dic forKey:key];
    [self.tableScrollView addSubview:listTableView];
    CGSize scrollViewW = CGSizeMake(tableViewX+kScreenWidth, kScreenWidth);
    self.tableScrollView.contentSize = scrollViewW;
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *d in dic) {
        [mArray addObject:d];
    }
    self.tableArray = mArray;
    
    
}
/**
 *  通过URL获取JSON
 *
 *  @param url  网络地址
 *  @param type top：顶部导航栏数据 table:tableView数据
 */
-(void)getNetWorkingJSON:(NSString *)http type:(NSString *)type tableViewX:(float)tableViewX{
    NSURL *url = [NSURL URLWithString:http];
    NSURLRequest *quest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    [NSURLConnection sendAsynchronousRequest:quest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (!connectionError) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if(httpResponse.statusCode == 200){
                NSError *error = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
                if(!error){
                    if([json[@"ecode"] isEqualToString:@"0"]){
                        NSMutableArray *mArray = [NSMutableArray array];
                        for (NSDictionary *d in json[@"edata"]) {
                            [mArray addObject:d];
                        }
                        if([type isEqualToString:@"top"]){
                            self.topCategoryDic = json[@"edata"];
                            //创建topScrollView中的按钮
                            [self performSelectorOnMainThread:@selector(createTopBtn:) withObject:json[@"edata"] waitUntilDone:YES];
                            //[self createTopBtn];
                        }else if([type isEqualToString:@"table"]){
                            self.tableDic = json[@"edata"];
                            [self createTableView:json[@"edata"] tableViewX:tableViewX];
                        }
                    }else{
                        NSLog(@"ecode=1.%@",json[@"message"]);
                    }
                }else{
                    NSLog(@"JSON解析错误，%@",error);
                }
            }else{
                NSLog(@"服务器返回错误。代码：%d",httpResponse.statusCode);
            }
        }
    }];
}

/**
 *  获取字符串的size
 *
 *  @param string 字符串
 *
 *  @return 字符串的size
 */
-(CGSize)getStringSize:(NSString *)string{
    CGSize strSize = [string boundingRectWithSize:CGSizeMake(kScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
    return strSize;
}
/**
 *  点击topScrollView上的按钮事件
 *
 *  @param sender 点击的按钮
 */
-(void)topBtnClick:(UIButton *)sender{

    for (int i = 0; i<self.allTopBtn.count; i++) {
        UIButton *btn = [self.allTopBtn objectAtIndex:i];
        if(sender.tag == btn.tag){
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            NSInteger x = sender.tag - 200;
            [self.tableScrollView setContentOffset:CGPointMake(kScreenWidth * x, -64) animated:YES];
        }else{
            [btn setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateNormal];
        }
    }
}

#pragma mark -- tableView方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.textLabel.font = strFont;
    //根据tag取全部数据字典内的每一个tableView的数据
    NSString *key = [NSString stringWithFormat:@"%d",tableView.tag];
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.text = self.allTableDic[key][indexPath.row][@"question"];
    return cell;
}

#pragma mark -- scrollView方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //计算scrollView的当前页
    int page = floor((scrollView.contentOffset.x - kScreenWidth/2)/kScreenWidth)+1;
    for (int i = 0; i<self.allTopBtn.count; i++) {
        [[self.allTopBtn objectAtIndex:i] setTitleColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1] forState:UIControlStateNormal];
    }
    [[self.allTopBtn objectAtIndex:page] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
@end
