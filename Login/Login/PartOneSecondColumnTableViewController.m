//
//  PartOneSecondColumnTableViewController.m
//  Login
//
//  Created by 何建新 on 16/3/10.
//  Copyright © 2016年 何建新. All rights reserved.
// PartOne二级列表

#import "PartOneSecondColumnTableViewController.h"
#import "getNetworkQuest.h"
#import "getUserInfo.h"
#import "PartOneTableViewCell.h"
#import "PartOneThirdColumnTableViewController.h"
@interface PartOneSecondColumnTableViewController ()

@end

@implementation PartOneSecondColumnTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    getUserInfo *user = [[getUserInfo alloc] init];
    self.userInfo = [user getUser];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];

    self.navigationItem.leftBarButtonItem = item;
    //获取网络数据
    getNetworkQuest *getNet = [[getNetworkQuest alloc] init];
    NSString *url = @"http://test.benniaoyasi.cn/api.php";
    NSString *param = [NSString stringWithFormat:@"m=api&c=category&a=listcategory&appid=1&mobile=%@&version=4.4.7&devtype=ios&uuid=21DCEFDF-5B85-4FF9-9A5D-5C3AD103D083&leval=%@",self.userInfo,self.leval];
    [getNet sendGetQuest2:url param:param];
    NSData *data = getNet.data;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    if ([dic[@"ecode"] isEqualToString:@"0"]) {
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *d in dic[@"edata"]) {
            [mArray addObject:d];
        }
        self.cateData = mArray;
    }else{
        
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//返回上一级
-(void)goBack{

    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cateData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    PartOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    // Configure the cell...
    if (cell == nil) {
        cell = [[PartOneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    cell.nameLabel.text = self.cateData[indexPath.row][@"english"];
    
    
    
    NSString *str = cell.nameLabel.text;
    UIFont *strFont = cell.nameLabel.font;
    CGSize strSize = [str sizeWithAttributes:@{NSFontAttributeName:strFont}];
    [cell.nameLabel setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width - strSize.width)/2, 0, strSize.width, 52)];
    //栏目标新图标
    if ([self.cateData[indexPath.row][@"newflg"] isEqualToString:@"1"]) {
        //计算图标位置
        CGRect newImageViewCGRect = CGRectMake(cell.nameLabel.frame.origin.x + cell.nameLabel.frame.size.width + 20, 17, 25, 10);
        //创建图片对象
        cell.imageNewView = [[UIImageView alloc] initWithFrame:newImageViewCGRect];
        cell.imageNewView.image = [UIImage imageNamed:@"new@2x.png"];
        //加入图片对象
        [cell.contentView addSubview:cell.imageNewView];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PartOneThirdColumnTableViewController *third = [[PartOneThirdColumnTableViewController alloc] init];

    third.cid =  [self.cateData[indexPath.row][@"id"] intValue];
    third.title = self.cateData[indexPath.row][@"english"];
    
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    third.navigationItem.leftBarButtonItem = btnItem;
    
    
    
    [self.navigationController pushViewController:third animated:YES];
    
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

@end
