//
//  PartTwoSecondColumnTableViewController.m
//  Login
//
//  Created by 何建新 on 16/3/28.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoSecondColumnTableViewController.h"
#import "getNetworkQuest.h"
#import "getUserInfo.h"
#import "PartOneTableViewCell.h"
#import "PartTwoThreeTableViewController.h"
@interface PartTwoSecondColumnTableViewController ()
@property(nonatomic, copy)NSArray *cateData;
@end

@implementation PartTwoSecondColumnTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = barButton;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    getNetworkQuest *getNet = [[getNetworkQuest alloc] init];
    /*
     http://test.benniaoyasi.cn/api.php?c=content&a=listcontent_part2_3&mobile=18600562546&version=4.4.9&devtype=ios&uuid=81CF49BF-F7F0-4E29-9884-6B343F9A415C&leval=People&appid=1&pageindex=0&pagenum=10
     */
    NSString *url = @"http://test.benniaoyasi.cn/api.php";
    NSString *param = [NSString stringWithFormat:@"c=content&a=listcontent_part2_3&mobile=%@&version=4.4.9&devtype=ios&uuid=81CF49BF-F7F0-4E29-9884-6B343F9A415C&leval=%@&appid=1&pageindex=0&pagenum=10",self.mobile,self.cateDic[@"evalue"]];
    [getNet sendGetQuest2:url param:param];
    NSData *data = getNet.data;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([dic[@"ecode"] isEqualToString:@"0"]) {
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *d in dic[@"edata"]) {
            [mArray addObject:d];
        }
        self.cateData = mArray;
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.cateData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    PartOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (cell == nil) {
        cell = [[PartOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.textLabel.text = self.cateData[indexPath.row][@"question"];
    NSString *str = self.cateData[indexPath.row][@"question"];
    UIFont *strFont = cell.textLabel.font;
    CGSize strSize = [str sizeWithAttributes:@{NSFontAttributeName:strFont}];
    [cell.nameLabel setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - strSize.width)/2, 0, strSize.width, 52)];
    //计算图片标记
    if([self.cateData[indexPath.row][@"newflg"] isEqualToString:@"1"]){
        //CGRect newImageViewCGRect = CGRectMake(cell.nameLabel.frame.origin.x + cell.nameLabel.frame.size.width + 20, 17, 25, 10);
        CGRect newImageViewCGRect = CGRectMake([UIScreen mainScreen].bounds.size.width-35, 3, 25, 10);
        //创建图片
        cell.imageNewView = [[UIImageView alloc] initWithFrame:newImageViewCGRect];
        cell.imageNewView.image = [UIImage imageNamed:@"new@2x.png"];
        [cell.contentView addSubview:cell.imageNewView];
    }
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PartTwoThreeTableViewController *partTwo = [[PartTwoThreeTableViewController alloc] init];
    partTwo.cateDic = self.cateData[indexPath.row];
    partTwo.mobile = self.mobile;
    partTwo.title = self.cateData[indexPath.row][@"question"];
    [self.navigationController pushViewController:partTwo animated:YES];
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
#pragma mark -返回上一级栏目
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
