//
//  PartOneThirdColumnTableViewController.m
//  Login
//
//  Created by 何建新 on 16/3/16.
//  Copyright © 2016年 何建新. All rights reserved.
//  PartOne第三级栏目

#import "PartOneThirdColumnTableViewController.h"
#import "getUserInfo.h"
#import "getNetworkQuest.h"
#import "PartOneTableViewCell.h"
#import "PartOneContentViewController.h"
@interface PartOneThirdColumnTableViewController ()

@end

@implementation PartOneThirdColumnTableViewController
/*
 http://test.benniaoyasi.cn/api.php?m=api&c=content&a=listcontent&appid=1&mobile=(null)&version=4.4.7&devtype=ios&uuid=21DCEFDF-5B85-4FF9-9A5D-5C3AD103D083&cid=73
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    getUserInfo *info = [[getUserInfo alloc] init];
    self.mobile = [info getUser];
    getNetworkQuest *getNet = [[getNetworkQuest alloc] init];
    NSString *url = @"http://test.benniaoyasi.cn/api.php";
    NSString *param = [NSString stringWithFormat:@"?m=api&c=content&a=listcontent&appid=1&mobile=%@&version=4.4.7&cid=%d",self.mobile,self.cid];
    [getNet sendGetQuest2:url param:param];
    self.date = [NSJSONSerialization JSONObjectWithData:getNet.data options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *mArray = [NSMutableArray array];

    if ([self.date[@"ecode"] isEqualToString:@"0"]) {
        for (NSDictionary *dic in self.date[@"edata"]) {
            [mArray addObject:dic];
        }
        self.array = mArray;
    }
    
    
//    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
//    self.navigationItem.leftBarButtonItem = btnItem;
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

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"thirdCell";

    PartOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[PartOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    //NSLog(@"%@",self.array[indexPath.row][@"question"]);
    cell.nameLabel.text = self.array[indexPath.row][@"question"];
    
    cell.nameLabel.font = [UIFont fontWithName:@"Arial" size:17.0];
    
    [cell.nameLabel setFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 20, 52)];
    if ([self.array[indexPath.row][@"newflg"] isEqualToString:@"1"]) {
        CGRect newImageViewCGRect = CGRectMake(cell.nameLabel.frame.origin.x + cell.nameLabel.frame.size.width + 20, 17, 25, 20);
        cell.imageNewView = [[UIImageView alloc] initWithFrame:newImageViewCGRect];
        cell.imageNewView.image = [UIImage imageNamed:@"hard.png"];
    }
    cell.nameLabel.textAlignment = NSTextAlignmentLeft;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PartOneContentViewController *content = [[PartOneContentViewController alloc] init];
    content.cid = self.cid;
    content.navigationItem.title = self.array[indexPath.row][@"question"];
    
    
    NSString *url = @"http://test.benniaoyasi.cn/api.php";
    NSString *param = [NSString stringWithFormat:@"?m=api&c=content&a=listcontent&appid=1&mobile=%@&version=4.4.7&devtype=ios&uuid=21DCEFDF-5B85-4FF9-9A5D-5C3AD103D083&cid=%d",self.mobile,self.cid];
    getNetworkQuest *quest = [[getNetworkQuest alloc] init];
    [quest sendGetQuest2:url param:param];
    NSData *data = quest.data;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *mArray = [NSMutableArray array];
    if ([dic[@"ecode"] isEqualToString:@"0"]) {
        
        for (NSDictionary *d in dic[@"edata"]) {
            if ([d[@"question"] isEqualToString:self.array[indexPath.row][@"question"]]) {
                
               [mArray addObject:d]; 
            }
            
        }
        
    }
    content.dataDic = mArray[0];
    
    
    [self.navigationController pushViewController:content animated:YES];
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
