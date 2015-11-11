//
//  ViewController.m
//  02-国旗选择
//
//  Created by 何建新 on 15/11/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "Flag.h"
#import "FlagView.h"
@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic, strong)NSArray *flags;
@end

@implementation ViewController
-(NSArray *)flags
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"flags" ofType:@"plist"];
    if (_flags == nil) {
        NSArray * tempArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in tempArray) {
            Flag *flag = [Flag flagWithDict:dict];
            [array addObject:flag];
        }
        _flags = array;
    }
    return _flags;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建pickerView
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    CGFloat pickerHeight = pickerView.frame.size.height;
    pickerView.frame = CGRectMake(pickerView.frame.origin.x, ((screenHeight - pickerHeight) * 0.5), pickerView.frame.size.width, pickerView.frame.size.height);
    [self.view addSubview:pickerView];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    
   
    
}
//返回多少组
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//第component组有多少行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    return self.flags.count;
    
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    FlagView *flagView = [FlagView flagView];
    flagView.flag = self.flags[row];
    //flagView.frame = CGRectMake(0, 0, 100, 44);
    //flagView.backgroundColor = [UIColor redColor];
    return  flagView;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60;
}
@end
