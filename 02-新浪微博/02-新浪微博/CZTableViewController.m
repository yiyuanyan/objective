//
//  CZTableViewController.m
//  02-新浪微博
//
//  Created by 何建新 on 15/10/26.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZTableViewController.h"
#import "CZMicroBlog.h"
#import "CZMicroBlogCell.h"
#import "CZMicroBlogFrame.h"
@interface CZTableViewController ()

@end

@implementation CZTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.microBlogFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CZMicroBlogCell *cell = [CZMicroBlogCell microBlogCellWithTableView:tableView];
    cell.microBlogFrame = self.microBlogFrames[indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
#pragma mark - 代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出frame模型
    CZMicroBlogFrame *microBlogFrame = self.microBlogFrames[indexPath.row];
    return microBlogFrame.rowHeight;
}
#pragma mark - 懒加载
-(NSArray *)microBlogFrames
{
    if (_microBlogFrames == nil) {
        NSArray *microBlogs = [CZMicroBlog microBlogs];
        //计算所有的frame和行高并保存
        //把数据模型转frame模型
        NSMutableArray *arrayM = [NSMutableArray array];
        for (CZMicroBlog *microBlog in microBlogs) {
            CZMicroBlogFrame *frame = [[CZMicroBlogFrame alloc]init];
            frame.microBlog = microBlog;
            [arrayM addObject:frame];
        }
        _microBlogFrames = arrayM;
    }
    return _microBlogFrames;
}


@end
