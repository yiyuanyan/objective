//
//  ViewController.m
//  模拟科技头条
//
//  Created by 何建新 on 15/12/22.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "CZNews.h"
#import "CZNewsimageCell.h"
#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)

#endif
@interface ViewController ()
@property(nonatomic, strong)NSArray *newsList;
@end

@implementation ViewController
//重写newsList属性的set方法
-(void)setNewsList:(NSArray *)newsList
{
    _newsList = newsList;
    [self.refreshControl endRefreshing];
    //因为是异步请求，有数据后要刷新表格
    [self.tableView reloadData];
}

-(IBAction)loadJSON{
    [CZNews newsWithUrl:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1428742869/type/0?channel=appstore&uuid=64543C0F-89E1-4D63-B947-DB4C504D13B1&net=5&model=iPhone&ver=1.0.5" completion:^(NSArray *array) {
        self.newsList = array;
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadJSON];
    self.refreshControl.tintColor = [UIColor blackColor];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"更新中..." attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];


}


//数据源的方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *reuseId = @"news";
    CZNews *news = self.newsList[indexPath.row];
    
    CZNewsimageCell *cell = [tableView dequeueReusableCellWithIdentifier:[CZNewsimageCell getReuseId:news]];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
//    }
    
    cell.news = news;
    
    return cell;
}
@end
