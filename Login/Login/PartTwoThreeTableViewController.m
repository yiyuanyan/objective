//
//  PartTwoThreeTableViewController.m
//  Login
//
//  Created by 何建新 on 16/4/4.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoThreeTableViewController.h"
#import "getNetworkQuest.h"
#import "getUserInfo.h"
#import "PartTwoThreeTableViewCell.h"
@interface PartTwoThreeTableViewController ()
@property(nonatomic, copy)NSDictionary *contentDic;
@property(nonatomic, strong) NSString *quest;
@property(nonatomic, copy) NSDictionary *p2;
@property(nonatomic, copy) NSDictionary *p3;
@property(nonatomic, assign)BOOL hindex;
@end

@implementation PartTwoThreeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.hindex = 0;
    getUserInfo *mobile = [[getUserInfo alloc]init];
    self.mobile = [mobile getUser];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = item;
    NSString *url = @"http://test.benniaoyasi.cn/api.php";
    NSString *param = [NSString stringWithFormat:@"m=api&c=content&a=contentinfo&appid=1&mobile=%@&version=4.4.9&devtype=ios&uuid=81CF49BF-F7F0-4E29-9884-6B343F9A415C&id=%@",self.mobile,self.cateDic[@"id"]];
    
    getNetworkQuest *quest = [[getNetworkQuest alloc]init];
    [quest sendGetQuest2:url param:param];
    NSData *data = quest.data;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSMutableDictionary *contentDic = [NSMutableDictionary dictionary];
    if ([dic[@"ecode"] isEqualToString:@"0"]) {
        for (NSDictionary *d in dic[@"edata"]) {
            [contentDic addEntriesFromDictionary:d];
        }
    }
    self.contentDic = contentDic;
    self.quest = contentDic[@"title"];
    self.p2 = contentDic[@"part2List"];
    self.p3 = contentDic[@"part3List"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.conDic = contentDic;
    NSLog(@"%@",self.conDic[@"part2List"]);
    _part2List = [NSMutableArray array];
    for (NSDictionary *d in self.conDic[@"part2List"]) {
        TMContent *TM = [[TMContent alloc] init];
        TM.english = d[@"p2_english"];
        TM.chines = d[@"p2_chines"];
        TM.audio = d[@"p2_audio"];
        TM.cellId = [NSString stringWithFormat:@"part2List%@-%@",d[@"yid"],d[@"id"]];
        [_part2List addObject:TM];
        
    }
    _part3List = [NSMutableArray array];
    for (NSDictionary *d in self.conDic[@"part3List"]) {
        TMContent *TM = [[TMContent alloc] init];
        TM.english = d[@"p2_english"];
        TM.chines = d[@"p2_chines"];
        TM.audio = d[@"p2_audio"];
        TM.cellId = [NSString stringWithFormat:@"part3List%@-%@",d[@"yid"],d[@"id"]];
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
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return self.p2.count;
    }else{
        return self.p3.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PartTwoThreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        //cell = [[PartTwoThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        //if(indexPath.section == 0){
        cell = [[PartTwoThreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell" contentDic:self.contentDic indexPath:indexPath];
        //}
        NSLog(@"%d",self.hindex);
        cell.hindex = self.hindex;
    }
    
    // Configure the cell...
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"问题";
    }else if(section == 1){
        return @"Part2List";
    }else{
        return @"Part3List";
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.hindex == 0){
        self.hindex = 1;
    }else{
        self.hindex = 0;
    }
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        TMContent *TM = self.part2List[indexPath.row];
        TM.state = !TM.state;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if(indexPath.section == 2){
        TMContent *TM = self.part3List[indexPath.row];
        TM.state = !TM.state;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
//根据字符串返回高度
-(CGFloat)getStringHeight:(NSString *)string{
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGRect strRect = [string boundingRectWithSize:CGSizeMake(kScreenWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    return CGRectGetHeight(strRect);
}
*/

@end
