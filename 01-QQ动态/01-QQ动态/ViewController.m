//
//  ViewController.m
//  01-QQ动态
//
//  Created by 何建新 on 15/11/3.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - 数据源方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 2;
    }else{
        return 3;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseId = @"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"found_icons_qzone"];
        cell.textLabel.text = @"QQ空间";
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"found_icons_gamecenter"];
            cell.textLabel.text = @"QQ游戏";
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"found_icons_readcenter"];
            cell.textLabel.text = @"QQ阅读";
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"found_icons_folder"];
            cell.textLabel.text = @"QQ文件助手";
        }else if (indexPath.row == 1){
            cell.imageView.image = [UIImage imageNamed:@"found_icons_location"];
            cell.textLabel.text = @"附近的人";
        }else if (indexPath.row == 2){
            cell.imageView.image = [UIImage imageNamed:@"found_icons_saosao"];
            cell.textLabel.text = @"扫一扫";
        }
    }
    
    
    return cell;
}

@end
