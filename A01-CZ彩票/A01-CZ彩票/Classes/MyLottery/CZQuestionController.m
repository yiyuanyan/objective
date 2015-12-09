//
//  CZQuestionController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/9.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZQuestionController.h"
#import "CZQuestion.h"
#import "CZQuestionContentController.h"
@interface CZQuestionController ()
@property(nonatomic,strong)NSArray *questions;
@end

@implementation CZQuestionController
//懒加载
-(NSArray *)questions
{
    if (_questions == nil) {
        //加载question文件
        NSString *path = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //字典转模型
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            CZQuestion *question = [CZQuestion questionWithDic:dic];
            [mArray addObject:question];
        }
        _questions = mArray.copy;
    }
    return _questions;
}
-(void)setData{
    //把quesion转换CZItem对象
    NSMutableArray *mArray = [NSMutableArray array];
    for (CZQuestion *question in self.questions) {
        CZItem *item = [CZItemArrow itemWithTitle:question.title icon:nil option:^{
            CZQuestionContentController *vc = [[CZQuestionContentController alloc]init];
            vc.question = question;
            
            UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeClick)];
            
            vc.navigationItem.leftBarButtonItem = item;
            
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
            
            [self presentViewController:nav animated:YES completion:nil];
        }];
        [mArray addObject:item];
    }
    CZGroup *group = [CZGroup groupWithItems:mArray.copy];
    self.groups = @[group];
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"常见问题";
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, -1)];
}
-(void)closeClick{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
