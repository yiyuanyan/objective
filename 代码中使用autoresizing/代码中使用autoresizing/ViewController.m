//
//  ViewController.m
//  代码中使用autoresizing
//
//  Created by 何建新 on 15/11/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong)UIView *blueView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *blueView = [[UIView alloc]init];
    [self.view addSubview:blueView];
    blueView.backgroundColor = [UIColor blueColor];
    blueView.center = self.view.center;
    blueView.bounds = CGRectMake(0, 0, 200, 200);
    self.blueView = blueView;
    UIView *redView = [[UIView alloc]init];
    [blueView addSubview:redView];
    redView.backgroundColor = [UIColor redColor];
    redView.center = CGPointMake(blueView.bounds.size.width * 0.5, blueView.bounds.size.height * 0.5);
    redView.bounds = CGRectMake(0, 0, 100, 100);
    /**
     *UIViewAutoresizingNone                 = 0,
     UIViewAutoresizingFlexibleLeftMargin   = 1 << 0,
     UIViewAutoresizingFlexibleWidth        = 1 << 1,
     UIViewAutoresizingFlexibleRightMargin  = 1 << 2,
     UIViewAutoresizingFlexibleTopMargin    = 1 << 3,
     UIViewAutoresizingFlexibleHeight       = 1 << 4,
     UIViewAutoresizingFlexibleBottomMargin = 1 << 5
     */
    //四边固定
    //redView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //四周灵活，中间固定
    redView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGRect bounds = self.blueView.bounds;
    bounds.size.width += 10;
    bounds.size.height += 10;
    self.blueView.bounds = bounds;
}


@end
