//
//  CZMorePushController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/3.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZMorePushController.h"
#import "CZItem.h"
#import "CZGroup.h"
#import "CZItemArrow.h"
#import "CZItemCell.h"
@interface CZMorePushController ()
@property(nonatomic, strong)NSArray *groups;
@end

@implementation CZMorePushController
-(instancetype)init
{
    //返回分组模式
    return [super initWithStyle:UITableViewStyleGrouped];
}
-(NSArray *)groups
{
    if (_groups == nil) {
        [self setDate];
    }
    return _groups;
}
-(void)setDate
{
    //第一组
    CZItem *item11 = [CZItemArrow itemWithTitle:@"开奖推送" desController:nil];
    
    CZItem *item12 = [CZItemArrow itemWithTitle:@"比分直播推送" desController:nil];
    CZItem *item13 = [CZItemArrow itemWithTitle:@"中奖动画" desController:nil];
    CZItem *item14 = [CZItemArrow itemWithTitle:@"购彩提醒" desController:nil];
    
    CZItem *item15 = [CZItemArrow itemWithTitle:@"圈子推送" desController:nil];
    
    
    CZGroup *group = [CZGroup groupWithItems:@[item11,item12,item13,item14,item15]];
    self.groups = @[group];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg"]];
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 15)];
    
}

//实现跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //去掉cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //获取当前cell的对应模型
    CZGroup *group = self.groups[indexPath.section];
    CZItem *item = group.items[indexPath.row];
    //判断是否是CZItemArrow的对象
    if ([item isKindOfClass:[CZItemArrow class]]) {
        if (item.option) {
            item.option();
        }else if(item.desController){
            UIViewController *vc = [[item.desController alloc]init];
            vc.title = item.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    CZGroup *group = self.groups[section];
    
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CZItemCell *cell = [CZItemCell cellWithTableView:tableView];
    CZGroup *group = self.groups[indexPath.section];
    CZItem *item = group.items[indexPath.row];
    cell.item = item;
    return cell;
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
