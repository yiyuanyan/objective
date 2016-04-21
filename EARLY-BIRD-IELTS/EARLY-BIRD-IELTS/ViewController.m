//
//  ViewController.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/14.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "StudyViewController.h"
#import "Part1ViewController.h"
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
    UIButton *Part1Btn = [[UIButton alloc] initWithFrame:CGRectMake(80, 150, 80, 40)];
    [Part1Btn setTitle:@"PARY1" forState:UIControlStateNormal];
    [Part1Btn addTarget:self action:@selector(PartBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [Part1Btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.view addSubview:Part1Btn];
    [self.view addSubview:startStudyBtn];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)startStudyBtnClick{
    StudyViewController *studyView = [[StudyViewController alloc] init];
    
    [self.navigationController pushViewController:studyView animated:YES];
}
-(void)PartBtnClick{
    Part1ViewController *Part1View = [[Part1ViewController alloc] initWithNibName:@"Part1View" bundle:nil];
    Part1View.title = @"PART1";
    
    [self.navigationController pushViewController:Part1View animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
