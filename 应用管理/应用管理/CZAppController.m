//
//  CZAppController.m
//  应用管理
//
//  Created by 何建新 on 15/11/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZAppController.h"
#import "CZApp.h"
#import "CZAppCell.h"
@interface CZAppController ()<CZAppCellDelegate>

@end

@implementation CZAppController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.rowHeight = 70;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.apps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CZAppCell *cell = [tableView dequeueReusableCellWithIdentifier:@"appCell"];
    cell.app = self.apps[indexPath.row];
    
    //让控制器称为CZAppCell的代理
    cell.delegate = self;
    
    return cell;
}
#pragma mark - 实现AppCell的代理方法
-(void)appCellDownLoad:(CZAppCell *)appCell downloadAppBtn:(UIButton *)button
{
    CGRect bounds = self.tableView.bounds;
    CGFloat margin = 20;
    CGFloat tipW = bounds.size.width - margin * 2;
    CGFloat tipH = 44;
    CGFloat tipX = margin;
    CGFloat tipY = (bounds.size.height - tipH) * 0.5;
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(tipX, tipY, tipW, tipH)];
    tipLabel.text = @"下载完毕";
    tipLabel.backgroundColor = [UIColor lightGrayColor];
    tipLabel.font = [UIFont systemFontOfSize:24];
    tipLabel.alpha = 0.0;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    [UIView animateKeyframesWithDuration:1.0 delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        tipLabel.alpha = 0.8;
    } completion:^(BOOL finished) {
        tipLabel.alpha = 0.0;
        [tipLabel removeFromSuperview];
        button.enabled = NO;
    }];
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
#pragma mark - 懒加载
-(NSArray *)apps
{
    if (_apps == nil) {
        _apps = [CZApp apps];
    }
    return _apps;
}

@end
