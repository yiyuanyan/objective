//
//  CZBaseSettingController.m
//  A01-CZ彩票
//
//  Created by apple on 15-6-16.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CZBaseSettingController.h"

@interface CZBaseSettingController ()

@end

@implementation CZBaseSettingController

//重写init方法，设置分组
- (instancetype)init{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSArray *)groups{
    if (_groups == nil) {
        //填数据
        [self setData];
    }
    return _groups;
}

- (void)setData{
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //第一组和最顶部的间距
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
    //设置每一组的间距 15
    self.tableView.sectionHeaderHeight = 15;
    self.tableView.sectionFooterHeight = 0;
    
    //设置tableView的背景图片
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
}


//tableView的代理方法  选中某个cell的时候执行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //去掉cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    //1 获取当前cell对应的模型对象
    CZGroup *group = self.groups[indexPath.section];
    CZItem *item = group.items[indexPath.row];
    
    //2 判断当前的对象，是什么类型，是要跳转还是执行block
    //判断item对象，是否是CZItemArrow的对象
    if ([item isKindOfClass:[CZItemArrow class]]) {
        if (item.option) {
            //执行block
            item.option();
        }else if(item.desController){
            
            //跳转到desController控制器
            UIViewController *vc = [item.desController new];
            //设置标题
            vc.title = item.title;
            
            [self.navigationController pushViewController:vc animated:YES]; ;
        }
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.groups.count;//共多少组
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    
    //    return [[self.groups[section] items] count];
    
    //返回每一组多少行
    CZGroup *group = self.groups[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //1
    CZItemCell *cell = [CZItemCell cellWithTableView:tableView];
    
    //2
    CZGroup *group = self.groups[indexPath.section];
    
    CZItem *item = group.items[indexPath.row];
    
    cell.item = item;
    
    
    //3
    return cell;
}
//返回组头和组尾
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    CZGroup *group = self.groups[section];
    return group.footer;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CZGroup *group = self.groups[section];
    return group.header;
}

@end
