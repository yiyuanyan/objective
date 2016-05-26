//
//  SchoolTableViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/5/9.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "SchoolTableViewController.h"
#import "SchoolTableViewCell.h"
#import "CitysViewController.h"
#import "AFNetworking.h"
#import "SDWebImage/UIImageView+WebCache.h"
@interface SchoolTableViewController ()
@property(nonatomic, strong)NSMutableDictionary *dic;
@property(nonatomic, strong)NSArray *infoArray;
@end

@implementation SchoolTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"选择城市" style:UIBarButtonItemStylePlain target:self action:@selector(selectCity)];
    self.navigationItem.rightBarButtonItem = rightItem;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    NSString *url = @"";
    if(self.paramCity==NULL){
        [self getNetWorkingJson:@"http://testapp.benniaoyasi.com/api.php?m=api&c=Nschool&a=listSchool&appid=1&devtype=ios&version=1.0.1&uuid=01775B6A-D165-4CBE-8690-7FDA7DE875FE"];
    }else{
        url = [[NSString stringWithFormat:@"http://testapp.benniaoyasi.com/api.php?m=api&c=Nschool&a=listSchool&city=%@&appid=1&devtype=ios&version=1.0.1&uuid=01775B6A-D165-4CBE-8690-7FDA7DE875FE",self.paramCity] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self getNetWorkingJson:url];
        
    }
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --自定义方法
-(void)selectCity{
    CitysViewController *cityView = [[CitysViewController alloc] init];
    cityView.title = @"选择城市";
    [self.navigationController pushViewController:cityView animated:YES];
}
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getNetWorkingJson:(NSString *)url{
    NSLog(@"%@",url);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *ecode = [NSString stringWithFormat:@"%@",responseObject[@"ecode"]];
        if([ecode isEqualToString:@"0"]){
            NSMutableArray *mArray = [NSMutableArray array];
            for (NSDictionary *d in responseObject[@"edata"]) {
                [mArray addObject:d];
            }
            self.infoArray = mArray;
            self.dic = responseObject[@"edata"];
            [self.tableView reloadData];
        }else{
            self.dic = nil;
            self.infoArray = nil;
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.infoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //SchoolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    //if(cell == nil){
        SchoolTableViewCell *cell = [[SchoolTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    //}
    if(self.infoArray != nil){
        cell.dic = self.infoArray[indexPath.row];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
