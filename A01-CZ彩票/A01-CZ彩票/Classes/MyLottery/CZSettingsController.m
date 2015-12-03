//
//  CZSettingsController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/2.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZSettingsController.h"
#import "CZGroup.h"
#import "CZItem.h"
#import "CZItemArrow.h"
#import "CZRedeemCodeController.h"
#import "CZItemSwitch.h"
#import "CZItemCell.h"
//推动和提醒
#import "CZMorePushController.h"
@interface CZSettingsController ()

//存放分组
@property(nonatomic, strong)NSArray *groups;
@end

@implementation CZSettingsController
//从写init方法设置为分组样式
-(instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}
//懒加载
-(NSArray *)groups
{
    if (_groups == nil) {
        [self setData];
    }
    return _groups;
}
//填写数据
-(void)setData{
    //第一组
    CZItem *item11 = [CZItemArrow  itemWithTitle:@"使用兑换码" icon:@"RedeemCode" desController:[CZRedeemCodeController class]];
    
    CZGroup *group1 = [CZGroup groupWithItems:@[item11]];
    
    //第二组
    CZItem *item21 = [CZItemArrow itemWithTitle:@"推送和提醒" icon:@"MorePush" desController:[CZMorePushController class]];
    CZItem *item22 = [CZItemSwitch itemWithTitle:@"摇一摇机选" icon:@"handShake"];
    CZItem *item23 = [CZItemSwitch itemWithTitle:@"声音效果" icon:@"sound_Effect"];
    CZItem *item24 = [CZItemSwitch itemWithTitle:@"购彩小助手" icon:@"More_LotteryRecommend"];
    CZItem *item25 = [CZItemSwitch itemWithTitle:@"圈子仅Wifi加载图片" icon:@"More_QuanZi_NetFlowSwitchImage"];
    CZGroup *group2 = [CZGroup groupWithItems:@[item21,item22,item23,item24,item25]];
    
    
    
    //第三组
    CZItem *item31 = [CZItemArrow itemWithTitle:@"检查新版本" icon:@"MoreUpdate" option:^{
        NSLog(@"检查新版本");
    }];
    CZItem *item32 = [CZItem itemWithTitle:@"推荐给朋友" icon:@"MoreShare"];
    CZItem *item33 = [CZItem itemWithTitle:@"产品推荐" icon:@"MoreNetease"];
    CZItem *item34 = [CZItem itemWithTitle:@"关于" icon:@"MoreAbout"];
    CZGroup *group3 = [CZGroup groupWithItems:@[item31,item32,item33,item34]];
    self.groups = @[group1,group2,group3];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置第一组与顶部间距为15
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 15)];
    //设置每一组的间距为15
    self.tableView.sectionHeaderHeight = 15;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    //返回一共多少租
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //返回一组多少行
    return [[self.groups[section] items] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CZItemCell *cell = [CZItemCell cellWithTableView:tableView];
    CZGroup *group = self.groups[indexPath.section];
    CZItem *item = group.items[indexPath.row];
    cell.item = item;
    
    return cell;
}

//选中某个CELL执行。tableView的代理方法 didSelectRowAtIndexPath/选中某个cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //去掉CELL选中的状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //获取当前cell对应的模型对象
    CZGroup *group = self.groups[indexPath.section];
    CZItem *item = group.items[indexPath.row];
    
    //判断当前的对象是什么类型 是要跳转还是执行block
    //判断item是否是CZItemArrow对象
    if ([item isKindOfClass:[CZItemArrow class]]) {
        if (item.option) {
            //执行block方法
            item.option();
        }else if (item.desController){
            //如果控制器不为空，跳转
            UIViewController *vc = [[item.desController alloc]init];
            vc.title = item.title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
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
