//
//  CategoryTableViewController.m
//  Login
//
//  Created by 何建新 on 16/3/4.
//  Copyright © 2016年 何建新. All rights reserved.
//
/*
 http://test.benniaoyasi.cn/api.php?m=api&c=category&a=listcategory&appid=1&pid=1&mobile=18600562546&version=4.4.7&devtype=ios&uuid=21DCEFDF-5B85-4FF9-9A5D-5C3AD103D083
 */

#import "CategoryTableViewController.h"
#import "getNetworkQuest.h"
#import "alertMessageViewController.h"
@interface CategoryTableViewController ()
- (IBAction)backAction:(UIBarButtonItem *)sender;
//栏目数组
@property(nonatomic, copy) NSDictionary *categoryDic;
@property(nonatomic, copy) NSArray *catArray;
@end

@implementation CategoryTableViewController
-(NSArray *)catArray
{
    if (!_catArray) {
        _catArray = [NSArray array];
    }
    return _catArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self getCategorys];
    [self clearExtraLine:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.categoryDic.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    
    // Configure the cell...
    NSDictionary *dic = self.catArray[indexPath.row];
    cell.textLabel.text = dic[@"ename"];
    //NSLog(@"%@",self.catArray[indexPath.row]);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
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
#pragma mark - 自定义方法
- (IBAction)backAction:(UIBarButtonItem *)sender {
    //弹出提示信息
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"真的要注销吗" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *destuctiveBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //返回上一级
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
    [alert addAction:destuctiveBtn];
    [alert addAction:cancelBtn];
    [self presentViewController:alert animated:YES completion:nil];
}
//获取网络请求返回的JSON转换为ARRAY
-(void)getCategorys{
    NSString *urlStr = @"http://test.benniaoyasi.cn/api.php";
    NSString *mobile = [self userInfo];
    NSString *param = [NSString stringWithFormat:@"m=api&c=category&a=listcategory&appid=1&pid=1&mobile=%@&version=4.4.7",mobile];
    getNetworkQuest *quest = [[getNetworkQuest alloc] init];
    [quest sendGetQuest2:urlStr param:param];
    NSData *data = quest.data;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if ([dic[@"ecode"] isEqualToString:@"0"]) {
        self.categoryDic = dic[@"edata"];
        self.catArray = [dic objectForKey:@"edata"];
        NSLog(@"%@",self.catArray[0]);
    }else{
        alertMessageViewController *alert = [alertMessageViewController alertMessage:@"错误信息" message:@"返回错误"];
        [alert presentViewController:self animated:YES completion:nil];
    }
    
}

//读取用户配置信息
-(NSString *)userInfo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *mobile = [defaults valueForKey:@"username"];
    return mobile;
}
//去掉tableView不显示内容的cell
-(void)clearExtraLine:(UITableView *)tableView{
    //创建一个view
    UIView *view =[[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
@end
