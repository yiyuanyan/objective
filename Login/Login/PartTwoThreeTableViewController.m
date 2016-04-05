//
//  PartTwoThreeTableViewController.m
//  Login
//
//  Created by 何建新 on 16/3/31.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoThreeTableViewController.h"
#import "PartTwoThreeTableViewCell.h"
#import "getNetworkQuest.h"
#import "getUserInfo.h"
@interface PartTwoThreeTableViewController ()
@property(nonatomic, copy)NSDictionary *contentInfo;
@property(nonatomic, assign) NSInteger num;
@property(nonatomic, assign)CGFloat part2CellHeight;
@property(nonatomic, assign)CGFloat titleHeight;
@property(nonatomic, copy)NSIndexPath *createIndexPath;
@property(nonatomic, copy)NSIndexPath *clickIndexPath;

@end

@implementation PartTwoThreeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    getUserInfo *userInfo = [[getUserInfo alloc]init];
    self.mobile = [userInfo getUser];
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
    self.contentInfo = contentDic;
    NSLog(@"%@",self.contentInfo);
    //NSLog(@"%@",self.contentInfo);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

    NSInteger count = 0;
    if (section == 2) {
        count = [self.contentInfo[@"part2List"] count];
    }else if(section == 1){
        count = [self.contentInfo[@"part2List"] count];
    }else{
        count = 1;
    }
    self.num = section;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    PartTwoContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartTwoCell"];
//    if (cell == nil) {
//        cell = [[PartTwoContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PartTwoCell"];
//        
//    }
    self.createIndexPath = indexPath;
//    PartTwoContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartTwoCell"];
//    if (cell == nil) {
//        cell = [[PartTwoContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PartTwoCell"];
//    }else{
//        while ([cell.contentView.subviews lastObject] != nil) {
//            [[cell.contentView.subviews lastObject] removeFromSuperview];
//            //[[cell.contentView.subviews] removeFromSuperview];
//        }
//    }
    
    PartTwoContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[PartTwoContentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    
    if((indexPath.section == self.clickIndexPath.section) && (indexPath.row == self.clickIndexPath.row) && indexPath.section != 0){
        NSLog(@"点击的CELL和创建的CELL是同一个");
    }
    cell.indexPath = indexPath;
    cell.part2Dic = self.contentInfo[@"part2List"][indexPath.row];
    self.part2CellHeight = [cell getPart2CellHeight];
    cell.title = self.contentInfo[@"title"];
    self.titleHeight = [cell getTitleHeight]+10;
    
    
    // Configure the cell...
    //NSLog(@"%@",self.contentInfo[@"part2List"][indexPath.row]);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.clickIndexPath = indexPath;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle = nil;
    if (section == 2) {
        headerTitle = @"Part3List";
    }else if(section == 1){
        headerTitle = @"Part2List";
    }else{
        headerTitle = @"问题";
    }
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    headerView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 1, 100, 42)];
    //titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = headerTitle;
    
    
    UIView *borderTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.frame.size.width, 1)];
    borderTop.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    UIView *borderBottom = [[UIView alloc] initWithFrame:CGRectMake(0, headerView.frame.size.height-1, headerView.frame.size.width, 1)];
    borderBottom.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
    [headerView addSubview:titleLabel];
    [headerView addSubview:borderTop];
    [headerView addSubview:borderBottom];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        return self.part2CellHeight;
    }else if(indexPath.section == 0){
        return 50;
    }else{
        return 10;
    }
    
}
-(CGFloat)getStringSize:(NSString *)string{
    UIFont *strFont = [UIFont fontWithName:@"Arial" size:14];
    CGSize strSize = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
    return strSize.height;
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
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
