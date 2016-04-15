//
//  PartTwoTableViewController.m
//  Login
//
//  Created by 何建新 on 16/4/8.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoTableViewController.h"
#import "getUserInfo.h"
#import "getNetworkQuest.h"
#import "TMContent.h"
#import "PartTwoTableViewCell.h"

#define kScreenWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
@interface PartTwoTableViewController ()
@property(nonatomic, strong)NSMutableDictionary *allDic;  //所有数据
@property(nonatomic, strong)NSMutableArray *part2List;  //part2List数据
@property(nonatomic, copy)NSMutableArray *part3List;  //part3List数据

@end

@implementation PartTwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取用户手机号码
    getUserInfo *user = [[getUserInfo alloc] init];
    self.mobile = [user getUser];
    //添加返回按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = item;
    //获取网络数据
    NSString *url = @"http://test.benniaoyasi.cn/api.php";
    NSString *param = [NSString stringWithFormat:@"m=api&c=content&a=contentinfo&appid=1&mobile=%@&version=4.4.9&devtype=ios&uuid=81CF49BF-F7F0-4E29-9884-6B343F9A415C&id=%@",self.mobile,self.cateDic[@"id"]];
    getNetworkQuest *quest = [[getNetworkQuest alloc] init];
    [quest sendGetQuest2:url param:param];
    NSData *data = quest.data;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableDictionary *conDic = [NSMutableDictionary dictionary];
    if([dic[@"ecode"] isEqualToString:@"0"]){
        for (NSDictionary *d in dic[@"edata"]) {
            [conDic addEntriesFromDictionary:d];
        }
    }
    self.allDic = [NSMutableDictionary dictionary];
    self.allDic = conDic;
    NSLog(@"%@",self.allDic);
    _part2List = [NSMutableArray array];
    for (NSDictionary *d in self.allDic[@"part2List"]) {
        TMContent *TM = [[TMContent alloc] init];
        TM.english = d[@"p2_english"];
        TM.chines = d[@"p2_chines"];
        TM.audio = d[@"p2_audio"];
        [_part2List addObject:TM];
    }
    
    _part3List = [NSMutableArray array];
    for (NSDictionary *d in self.allDic[@"part3List"]) {
        TMContent *TM = [[TMContent alloc] init];
        TM.english = d[@"p3_english"];
        TM.chines = d[@"p3_chines"];
        TM.audio = d[@"p3_audio"];
        [_part3List addObject:TM];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return 1;
    }else if(section == 1){
        return self.part2List.count;
    }else{
        return self.part3List.count;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TMContent *TM = nil;
    UIFont *strFont = [UIFont systemFontOfSize:14];
    PartTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[PartTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }else{
        while([cell.contentView.subviews lastObject] != nil){
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    if(indexPath.section == 0){
        CGFloat titleHeight = [self stringHeight:self.allDic[@"title"]];
        //问题Label
        UILabel *enl = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, kScreenWidth, titleHeight+10)];
        enl.font = strFont;
        enl.numberOfLines = 0;
        enl.text = self.allDic[@"title"];
        
        //play和录音按钮
        UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-43, 5, 33, 33)];
        [playBtn setImage:[UIImage imageNamed:@"play_press"] forState:UIControlStateNormal];
        [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
        UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-83, 5, 33, 33)];
        [playBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [luyinBtn setImage:[UIImage imageNamed:@"luyin_press"] forState:UIControlStateNormal];
        [luyinBtn setImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateHighlighted];
        //play和录音按钮的view
        UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, enl.frame.size.height, kScreenWidth, 44)];
        btnView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        [btnView addSubview:luyinBtn];
        [btnView addSubview:playBtn];
        //总体View
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, enl.frame.size.height+btnView.frame.size.height)];
        [bgView addSubview:enl];
        [bgView addSubview:btnView];
        cell.enView = bgView;
        
        cell.clickButton = ^(NSIndexPath* indexPath){
            [self clickBtn:indexPath];
        };
        
        
        
    }else if (indexPath.section == 1){
        TM = self.part2List[indexPath.row];
    }else{
        TM = self.part3List[indexPath.row];
    }
    
    
    return cell;
}
-(void)clickBtn:(NSIndexPath *)indexPath{
    NSLog(@"sadfasdf");
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return [self stringHeight:self.allDic[@"title"]]+54;
    }
    return 50;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"问题";
    }else if(section == 1){
        return @"Part2List";
    }else{
        return @"Part3List";
    }
}
-(CGFloat)stringHeight:(NSString *)string{
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect strRect = [string boundingRectWithSize:CGSizeMake(kScreenWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    return CGRectGetHeight(strRect);
}

-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
