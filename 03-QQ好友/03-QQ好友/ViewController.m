//
//  ViewController.m
//  03-QQ好友
//
//  Created by 何建新 on 15/11/3.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "CZFriendGroup.h"
#import "CZFriend.h"
#import "CZGroupHeaderView.h"
#import "CZFriendCell.h"
@interface ViewController ()<CZGroupHeaderViewDelegate>
//这里存放friendGroup的数组
@property(nonatomic, strong)NSArray *friendGroups;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView.sectionFooterHeight = 44;
    //设置footerView后让footerView填充下面的空白。这样没有内容的cell就不会在显示分割线
    self.tableView.tableFooterView = [[UIView alloc]init];
    
}
#pragma mark - tableView数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return self.friendGroups.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CZFriendGroup *group = self.friendGroups[section];
    return group.isOpen ? group.friends.count : 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    /*
    NSString *reuseId = @"ID";
    //给cell设置数据
    //1.取出组模型,设置头像
    
    */
    //创建cell
    CZFriendCell *cell = [CZFriendCell friendCellWithTableView:tableView];
    CZFriendGroup *group = self.friendGroups[indexPath.section];
    CZFriend *friend = group.friends[indexPath.row];
    //设置数据
    cell.friend = friend;
    
    return cell;
}
//分组头部显示
//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    CZFriendGroup *group = self.friendGroups[section];
//    return group.name;
//}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    CZGroupHeaderView *headerView = [CZGroupHeaderView groupHeaderViewWithTableView:tableView];
    headerView.friendGroup = self.friendGroups[section];
    
    headerView.delegate = self;
    
    return headerView;
}
#pragma mark - 实现groupHeaderView的代理方法
-(void)groupHeadViewDidTouched:(CZGroupHeaderView *)headerView
{
    //刷新表格
    [self.tableView reloadData];
}
#pragma mark - 隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark -懒加载数组
-(NSArray *)friendGroups
{
    if (_friendGroups == nil) {
        _friendGroups = [CZFriendGroup friendGroups];
    }
    return _friendGroups;
}

@end
