//
//  ViewController.m
//  国旗练习
//
//  Created by 何建新 on 15/11/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "Flags.h"
#import "FlagView.h"
@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic, strong)NSArray *flags;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    [self.view addSubview:pickerView];
    pickerView.delegate = self;
    pickerView.dataSource = self;
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.flags.count;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    FlagView *flagView = [[NSBundle mainBundle]loadNibNamed:@"FlagView" owner:nil options:nil][0];
    flagView.flags = self.flags[row];
    return flagView;
}
-(NSArray *)flags
{
    if (_flags == nil) {
        _flags = [Flags flags];
    }
    return _flags;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60;
}
@end
