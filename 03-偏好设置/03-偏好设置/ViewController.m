//
//  ViewController.m
//  03-偏好设置
//
//  Created by 何建新 on 15/11/20.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)save:(UIButton *)sender;

- (IBAction)load:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(UIButton *)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"提莫" forKey:@"username"];
    [ud setBool:YES forKey:@"isOn"];
}

- (IBAction)load:(UIButton *)sender {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *userName = [ud objectForKey:@"username"];
    BOOL isOn = [ud boolForKey:@"isOn"];
    NSLog(@"%@",userName);
    NSLog(@"%d",isOn);
}
@end
