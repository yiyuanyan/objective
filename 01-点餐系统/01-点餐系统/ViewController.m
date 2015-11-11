//
//  ViewController.m
//  01-点餐系统
//
//  Created by 何建新 on 15/11/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property(nonatomic, strong)NSArray *foods;
//水果
@property(nonatomic, weak)IBOutlet UILabel *fruit;
//主食
@property(nonatomic, weak)IBOutlet UILabel *staple;
//饮料
@property(nonatomic, weak)IBOutlet UILabel *drink;
- (IBAction)randomClick:(UIButton *)sender;
@end

@implementation ViewController
//懒加载
-(NSArray *)foods
{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"foods" ofType:@"plist"];
    if (_foods == nil) {
        _foods = [NSArray arrayWithContentsOfFile:path];
    }
    
    return _foods;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    //初始化
    
    for (int i=0; i < self.foods.count; i++) {
        [self pickerView:self.pickerView didSelectRow:0 inComponent:i];
    }
}

//显示多少列选项组
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.foods.count;
}
//pickerView的第component组有多少行
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{

    return [self.foods[component]count];
}
//第component组的row行显示的内容
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{

    return self.foods[component][row];
}
//选择了component组的row行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //NSLog(@"%@",self.foods[component][row]);
    if (component == 0) {
        self.fruit.text = self.foods[0][row];
    }else if (component == 1){
        self.staple.text = self.foods[1][row];
    }else{
        self.drink.text = self.foods[2][row];
    }
}
- (IBAction)randomClick:(UIButton *)sender {
    for (int i = 0; i< self.foods.count; i++) {
        //返回的是上一行的行号。
        NSInteger index = [self.pickerView selectedRowInComponent:i];
        NSInteger random = [self randomValueWithOldValue:index lessThan:[self.foods[i]count]];
        //让pickerview滚动到某一行某一组
        [self.pickerView selectRow:random inComponent:i animated:YES];
        [self pickerView:self.pickerView didSelectRow:random inComponent:i];
    }
    
}
//生成一个与oldValue不同的随机数，并且小于lessThan
-(NSInteger)randomValueWithOldValue:(NSInteger)oldValue lessThan:(NSInteger)lessThan
{
    NSInteger random;
    do {
        random = arc4random() % lessThan;
    } while (random == lessThan);
    return random;
}
@end
