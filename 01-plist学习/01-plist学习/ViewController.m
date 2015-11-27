//
//  ViewController.m
//  01-plist学习
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
    //Home目录路径,沙盒目录
    //NSString *homePath = NSHomeDirectory();
    //NSLog(@"Home路径是：%@",homePath);
    //获取doc目录
    //1.字符串拼接
    //NSString *docPath = [homePath stringByAppendingString:@"/Documents"];
    //NSLog(@"Documents的路径是:%@",docPath);
    
    //NSString *docPath2 = [homePath stringByAppendingPathComponent:@"Documents"];
    //NSLog(@"%@",docPath2);
    //2.搜索路径找哪个文件夹在哪个范围 哪个文件夹，枚举类型   哪个范围，枚举类型   是否展开
    NSArray * array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, 1);
    NSString *filePath = [array[0] stringByAppendingPathComponent:@"test.plist"];
    NSLog(@"%@",array[0]);
    NSArray *arr = @[@"1",@"2222"];
    //写入文件到哪个目录  atomically:为是否安全线程写入
    [arr writeToFile:filePath atomically:YES];
    NSDictionary *dic = @{@"key":@"value"};
    [dic writeToFile:filePath atomically:YES];
}

- (IBAction)load:(UIButton *)sender {
    //查找Document目录路径
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, 1)[0];
    //制定目录下的文件名称
    NSString *filePath = [docPath stringByAppendingPathComponent:@"test.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"%@",dic);
}
@end
