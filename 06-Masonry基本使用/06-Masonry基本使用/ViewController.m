//
//  ViewController.m
//  06-Masonry基本使用
//
//  Created by 何建新 on 15/11/6.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#define MAS_SHORTHAND  //必须导入Masonry之前导入
//自动装箱
#define MAS_SHOTRHAND_GLOBALS
#import "Masonry.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __weak typeof (self) weakSelf = self;
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    //通过masonry添加约束
    //    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        //redView的top等于控制器的top在偏移20像素的位置
    //        make.top.equalTo(self.view.mas_top).with.offset(20);
    //
    //
    //
    //        make.left.equalTo(self.view.mas_left).with.offset(20);
    //
    //        make.right.equalTo(self.view.mas_right).with.offset(0);
    //
    //        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    //
    //    }];
    //第二种
//    [redView makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakSelf.view).offset(20);
//        make.left.equalTo(weakSelf.view).offset(20);
//        make.right.equalTo(weakSelf.view).offset(-20);
//        make.bottom.equalTo(weakSelf.view).offset(-20);
//    }];
    [redView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
