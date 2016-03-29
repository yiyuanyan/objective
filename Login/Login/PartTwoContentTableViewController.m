//
//  PartTwoContentTableViewController.m
//  Login
//
//  Created by 何建新 on 16/3/29.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoContentTableViewController.h"
#import "getNetworkQuest.h"
@interface PartTwoContentTableViewController ()
@property(nonatomic, copy)NSDictionary *contentInfo;
@property(nonatomic, assign) NSInteger num;
@end
/*
 http://test.benniaoyasi.cn/api.php?m=api&c=content&a=contentinfo&appid=1&mobile=18600562546&version=4.4.9&devtype=ios&uuid=81CF49BF-F7F0-4E29-9884-6B343F9A415C&id=518
*/
@implementation PartTwoContentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
        count = [self.contentInfo[@"part3List"] count];
    }else if(section == 1){
        count = [self.contentInfo[@"part2List"] count];
    }else{
        count = 1;
    }
    self.num = section;
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:14];
    cell.textLabel.numberOfLines = 0;
    NSString *cellText = nil;
    if (indexPath.section == 0) {
        cellText = self.contentInfo[@"title"];
        UIFont *strFont = cell.textLabel.font;
        CGSize strSize = [cellText sizeWithAttributes:@{NSFontAttributeName:strFont}];
        UITextView *contentText = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, strSize.height+35)];
        contentText.text = cellText;
        contentText.scrollEnabled = NO;
        contentText.backgroundColor = [UIColor blueColor];
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, contentText.frame.size.height, contentText.frame.size.width, 40)];
        btnView.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:contentText];
        [cell.contentView addSubview:btnView];
        NSLog(@"%f",contentText.frame.size.height+btnView.frame.size.height);
    }else if(indexPath.section == 1){
        cellText = self.contentInfo[@"part2List"][indexPath.row];
        NSLog(@"%@",cellText);
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float enHeight = 0.0;
    float cnHeight = 0.0;
    if(indexPath.section == 0){
        enHeight = [self getStringSize:self.contentInfo[@"title"]]+35+40;
        cnHeight = 0.0;
    }
    
    
    return enHeight+cnHeight;
}
-(float)getStringSize:(NSString *)string{
    UIFont *strFont = [UIFont fontWithName:@"Arial" size:14];
    CGSize strSize = [string sizeWithAttributes:@{NSFontAttributeName:strFont}];
    return strSize.height;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *headerTitle = nil;
    if (section == 2) {
        headerTitle = @"Part3List";
    }else if(section == 1){
        headerTitle = @"Part2List";
    }else{
        headerTitle = @"问题";
    }
    return headerTitle;
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
