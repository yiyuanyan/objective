//
//  PartOneContentViewController.m
//  Login
//
//  Created by 何建新 on 16/3/18.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartOneContentViewController.h"
#import "contentView.h"
#import "getNetworkQuest.h"
#import "getUserInfo.h"
@interface PartOneContentViewController ()
@property(nonatomic, strong)UIView *questView;
@property(nonatomic, assign)CGFloat questViewH;
@property(nonatomic, strong)UIView *answersView;
@property(nonatomic, strong)UIView *chineseView;
@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, assign)CGFloat scrollViewH;
@property(nonatomic, copy)NSString *info;
@property(nonatomic, strong) UIButton *answersBtn;
@property(nonatomic, strong) UIButton *chineseBtn;

@end

@implementation PartOneContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    getUserInfo *userInfo = [[getUserInfo alloc]init];
    self.info = [userInfo getUser];
    
    //scrollView.backgroundColor = [UIColor blueColor];
    //问题view
    self.questView = [self getQuestView];
    UIView *borderB = (UIView *)[self.questView viewWithTag:101];
    borderB.alpha = 0;
    //Answers按钮
    self.answersBtn = [[UIButton alloc] init];
    [self.answersBtn setTitle:@"Answers" forState:UIControlStateNormal];
    self.answersBtn.backgroundColor = [UIColor redColor];
    [self.answersBtn setFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height-100, ([UIScreen mainScreen].bounds.size.width/2)-20,30)];
    [self.answersBtn.layer setMasksToBounds:YES];
    [self.answersBtn.layer setCornerRadius:10.0];
    //按钮点击事件
    [self.answersBtn addTarget:self action:@selector(answersBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //chinese按钮
    self.chineseBtn = [[UIButton alloc] init];
    [self.chineseBtn setTitle:@"Chinese" forState:UIControlStateNormal];
    [self.chineseBtn setFrame:CGRectMake(self.answersBtn.frame.size.width+30, [UIScreen mainScreen].bounds.size.height-100, self.answersBtn.frame.size.width,30)];
    self.chineseBtn.backgroundColor = [UIColor whiteColor];
    [self.chineseBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.chineseBtn.layer setMasksToBounds:YES];
    [self.chineseBtn.layer setCornerRadius:10.0];
    [self.chineseBtn.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [self.chineseBtn.layer setBorderColor:CGColorCreate(colorSpace,(CGFloat[]){ 1, 0, 0, 1 })];
    [self.chineseBtn addTarget:self action:@selector(chineseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

    
    
    
    [self.scrollView addSubview:[self getAnswerView]];
    [self.scrollView addSubview:self.answersBtn];
    [self.scrollView addSubview:self.chineseBtn];
    [self.scrollView addSubview:[self getChineseView]];
    [self.scrollView addSubview:self.questView];
    
    if (self.answersView.alpha == 1 && self.chineseView.alpha == 1) {
        self.scrollViewH = self.questView.frame.size.height+self.answersView.frame.size.height+self.chineseView.frame.size.height;
    }else if(self.answersView.alpha == 0 && self.chineseView.alpha == 1){
        self.scrollViewH = self.questView.frame.size.height+self.chineseView.frame.size.height;
    }else if(self.answersView.alpha == 1 && self.chineseView.alpha == 0){
        self.scrollViewH = self.questView.frame.size.height+self.answersView.frame.size.height;
    }else{
        self.scrollViewH = [UIScreen mainScreen].bounds.size.height;
    }
    if (self.scrollViewH < [UIScreen mainScreen].bounds.size.height) {
        self.scrollViewH = [UIScreen mainScreen].bounds.size.height;
    }
    [self.scrollView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.scrollViewH)];
    //self.scrollView.backgroundColor = [UIColor blueColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];

    
    
    
    
    
}
-(UIView *)getQuestView{
    NSString *str = self.dataDic[@"question"];
    UIFont *strFont = [UIFont fontWithName:@"Arial" size:16];
    NSLog(@"%@",self.dataDic);
    contentView *cView = [[contentView alloc]init];
    UIView *allView = [cView stringView:str stringFont:strFont];
    
    //if (self.answersView.hidden == YES && self.chineseView.hidden == YES) {
        [allView setFrame:CGRectMake(0, (([UIScreen mainScreen].bounds.size.height-110)/2)-(allView.frame.size.height/2), allView.frame.size.width, allView.frame.size.height)];
    //}
    self.questViewH = allView.frame.size.height;
    //[allView setFrame:CGRectMake(0, 0, allView.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    return allView;
}
-(UIView *)getAnswerView{

    NSString *str = self.dataDic[@"p1_english"];
    UIFont *strFont = [UIFont fontWithName:@"Arial" size:16];
    contentView *aView = [[contentView alloc] init];
    self.answersView = [aView stringView:str stringFont:strFont];
    //self.answersView.backgroundColor = [UIColor redColor];
    self.answersView.alpha = 0;


    [self.answersView setFrame:CGRectMake(0, self.questView.frame.size.height+self.questView.frame.origin.y+1, self.answersView.frame.size.width, self.answersView.frame.size.height)];
    self.answersView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];

    return self.answersView;
}
-(UIView *)getChineseView{
    NSString *str = self.dataDic[@"p1_chines"];
    UIFont *strFont = [UIFont fontWithName:@"Arial" size:16];
    contentView *cView = [[contentView alloc] init];
    cView.hid = YES;
    self.chineseView = [cView stringView:str stringFont:strFont];
    if (self.answersView.alpha == 1) {
        [self.chineseView setFrame:CGRectMake(0, self.questView.frame.size.height+self.questView.frame.origin.y+1+self.answersView.frame.size.height+1, self.chineseView.frame.size.width, self.chineseView.frame.size.height-50)];
    }else{
        [self.chineseView setFrame:CGRectMake(0, self.questView.frame.size.height+self.questView.frame.origin.y+1, self.chineseView.frame.size.width, self.chineseView.frame.size.height-50)];
    }
    self.chineseView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.chineseView.alpha = 0;
    
    return self.chineseView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - answers按钮点击事件
-(void)answersBtnClick{
    UIView *borderB = [self.questView viewWithTag:101];
    borderB.alpha = 1;
    [UIView animateWithDuration:0.5 animations:^{

        self.answersBtn.alpha = 0;
        [self.questView setFrame:CGRectMake(0, 0, self.questView.frame.size.width, self.questView.frame.size.height)];
        [self.chineseBtn setFrame:CGRectMake(10, self.answersBtn.frame.origin.y, [UIScreen mainScreen].bounds.size.width-20, self.answersBtn.frame.size.height)];
        
    } completion:^(BOOL finished) {
        self.answersView.alpha=1;
        if (self.chineseView.alpha == 0) {
            
            [self.answersView setFrame:CGRectMake(0, self.questViewH, self.answersView.frame.size.width, self.answersView.frame.size.height+1)];
        }
    }];
}
-(void)chineseBtnClick{
    UIView *borderB = [self.questView viewWithTag:101];
    borderB.alpha = 1;
    self.chineseView.backgroundColor = [UIColor redColor];
    if (self.answersBtn.alpha == 1) {
        [UIView animateWithDuration:0.5 animations:^{
            self.chineseBtn.alpha = 0;
            [self.questView setFrame:CGRectMake(0, 0, self.questView.frame.size.width, self.questView.frame.size.height)];
            [self.answersBtn setFrame:CGRectMake(10, self.answersBtn.frame.origin.y, [UIScreen mainScreen].bounds.size.width-20, self.answersBtn.frame.size.height)];
        } completion:^(BOOL finished) {
            self.chineseView.alpha = 1;
            [self.chineseView setFrame:CGRectMake(0, self.questViewH+1, self.chineseView.frame.size.width, self.chineseView.frame.size.height+10)];
            UIView *borderC = [self.chineseView viewWithTag:101];
            borderC.alpha = 1;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            self.chineseBtn.alpha = 0;
            [self.scrollView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.questView.frame.size.height+self.chineseView.frame.size.height+self.answersView.frame.size.height+64)];
            [self.chineseView setFrame:CGRectMake(0, self.questViewH+self.answersView.frame.size.height, self.chineseView.frame.size.width, self.chineseView.frame.size.height+1)];
            self.chineseView.alpha = 1;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}
-(void)playBtnClick{
    NSLog(@"开始播放音频啦");
}
@end
