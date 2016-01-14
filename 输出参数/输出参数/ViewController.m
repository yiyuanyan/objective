//
//  ViewController.m
//  输出参数
//
//  Created by 何建新 on 15/12/29.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int a;
    int b;
    NSArray *numbers = @[@(50),@(80),@(20),@(30),@(90),@(60)];
    [self getMaxAndMin:numbers max:&a min:&b];
    NSLog(@"最大值:%d----------最小值:%d",a,b);
}

-(void)getMaxAndMin:(NSArray *)numbers max:(int *)max min:(int *)min{
    *max = [numbers[0] intValue];
    *min = [numbers[0] intValue];
    for (NSNumber *num in numbers) {
        //判断最大值
        if (*max < num.intValue) {
            *max = num.intValue;
        }
        //判断最小值
        if (*min > num.intValue) {
            *min = num.intValue;
        }
    }
    
}

@end
