//
//  ViewController.m
//  03-城市的选择
//
//  Created by 何建新 on 15/11/11.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "Province.h"
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property(nonatomic, strong)NSArray *provinces;
@property(nonatomic, assign)NSInteger selectedProIndex;
@end

@implementation ViewController
-(NSArray *)provinces
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"provinces" ofType:@"plist"];
    if (_provinces == nil) {
        NSArray *tempArray = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in tempArray) {
            Province *pro = [Province proinceWithDict:dict];
            [array addObject:pro];
        }
        _provinces = array;
    }
    return _provinces;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建pickerView
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    [self.view addSubview:pickerView];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.provinces.count;
    }else{
        //取到当前在那个省份下
        //NSInteger proIndex = [pickerView selectedRowInComponent:0];
        NSInteger proIndex = self.selectedProIndex;
        //通过get方法获取省份下面的cities在count
        return [[self.provinces[proIndex] cities] count];
    }
}
//选项卡内容
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0) {
        return [self.provinces[row] name];
    }else{
        NSInteger proIndex = [pickerView selectedRowInComponent:0];
//        @try {
//            <#Code that can potentially throw an exception#>
//        }
//        @catch (NSException *exception) {
//            <#Handle an exception thrown in the @try block#>
//        }
//        @finally {
//            <#Code that gets executed whether or not an exception is thrown#>
//        }
        return [self.provinces[proIndex] cities][row];
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        //选择了第1组，就刷新第2组
        [pickerView reloadComponent:1];
        //记录当前行
        _selectedProIndex = row;
    }
}
@end
