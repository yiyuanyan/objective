//
//  ViewController.m
//  Masonry基本使用
//
//  Created by 何建新 on 15/11/6.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    //通过masonry添加约束
    __weak typeof (self) weakSelf = self;
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        //redView的top等于控制器的top在偏移20像素的位置
        make.top.equalTo(weakSelf.view.mas_top).offset(20);
        
        make.left.equalTo(weakSelf.view.mas_left).offset(20);
        
        make.right.equalTo(weakSelf.view.mas_right).offset(-20);
        
        make.bottom.equalTo(weakSelf.view.mas_bottom).offset(-20);
    }];
}

@end
