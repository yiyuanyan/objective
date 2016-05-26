//
//  Part2TableViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/27.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "Part2TableViewController.h"

@interface Part2TableViewController ()

@end

@implementation Part2TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
    }
    // Configure the cell...
    
    return cell;
}


#pragma mark  自定义方法
-(void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
