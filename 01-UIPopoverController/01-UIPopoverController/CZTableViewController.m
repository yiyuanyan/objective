//
//  CZTableViewController.m
//  01-UIPopoverController
//
//  Created by 何建新 on 16/1/12.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "CZTableViewController.h"
#import "CZMenu.h"
@interface CZTableViewController ()
@property(nonatomic, strong)NSArray *allData;
@end

@implementation CZTableViewController
-(NSArray *)allData
{
    if (_allData == nil) {
        CZMenu *movie = [[CZMenu alloc]init];
        movie.name = @"电影";
        movie.imageName = @"movie";
        CZMenu *music = [[CZMenu alloc]init];
        music.name = @"音乐";
        music.imageName = @"music";
        CZMenu *video = [[CZMenu alloc]init];
        video.name = @"视频";
        video.imageName = @"video";
        
        
        _allData = @[movie,music,video];
    }
    return _allData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置展示的界面的大小
    self.preferredContentSize = CGSizeMake(200, 200);
}


#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.allData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    CZMenu *menu = self.allData[indexPath.row];
    cell.textLabel.text = menu.name;
    cell.imageView.image = [UIImage imageNamed:menu.imageName];
    
    return cell;
}




@end
