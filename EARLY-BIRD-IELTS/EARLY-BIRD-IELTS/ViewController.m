//
//  ViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/14.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "StudyViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setNeedsDisplay];
    [super.navigationController setNavigationBarHidden:YES];
    UIButton *startStudyBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 80, 80, 40)];
    [startStudyBtn setTitle:@"开始学习" forState:UIControlStateNormal];
    [startStudyBtn addTarget:self action:@selector(startStudyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [startStudyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:startStudyBtn];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)startStudyBtnClick{
    StudyViewController *studyView = [[StudyViewController alloc] init];
    
    [self.navigationController pushViewController:studyView animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
