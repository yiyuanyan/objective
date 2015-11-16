//
//  ViewController.m
//  05-键盘处理
//
//  Created by 何建新 on 15/11/11.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "CZToolBar.h"
@interface ViewController ()<UITextFieldDelegate, CZToolBarDelegate>
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property(nonatomic, weak)CZToolBar *toolBar;
@property(nonatomic, assign)NSUInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.time.delegate = self;
    self.city.delegate = self;
    self.textFields = @[self.time,self.city];
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    //设置datePicker为中文
    datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    //设置datePicker为年月日
    datePicker.datePickerMode = UIDatePickerModeDate;
    //监听datePicker事件
    [datePicker addTarget:self action:@selector(didSelectTime:) forControlEvents:UIControlEventValueChanged];
    
    //点击input输入框时加入一个视图，默认是键盘视图
    self.time.inputView = datePicker;
    
    
    
    //获取自定义toolbar
    //UIView *view = [[NSBundle mainBundle]loadNibNamed:@"CZToolBar" owner:nil options:nil][0];
    CZToolBar *toolBar = [CZToolBar toolBar];  //用自定义类加载xib文件
    self.toolBar = toolBar;
    //给CZToolBar设定代理
    toolBar.toolBarDelegate = self;
    //点击输入框加入一个辅助视图，默认没有辅助视图
    self.time.inputAccessoryView = toolBar;
    self.city.inputAccessoryView = toolBar;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    _index = [self.textFields indexOfObject:textField];
    if ([[self.textFields firstObject] isEqual:textField]) {
        self.toolBar.preButton.enabled = NO;
        self.toolBar.nextButton.enabled = YES;
    }else if ([[self.textFields lastObject] isEqual:textField]){
        self.toolBar.nextButton.enabled = NO;
        self.toolBar.preButton.enabled = YES;
    }
}
//实现CZToolBarDelegate代理方法
-(void)toolBar:(CZToolBar *)toolBar didClickWithBtnType:(CZToolBarButtonType)type
{
    switch (type) {
        case CZToolBarButtonTypePre:
            NSLog(@"上一个");
            [self.textFields[--_index] becomeFirstResponder];
            break;
        case CZToolBarButtonTypeNext:
            NSLog(@"下一个");
            [self.textFields[++_index] becomeFirstResponder];
            break;
        case CZToolBarButtonTypeDone:
            NSLog(@"完成");
            [self.view endEditing:YES];
            break;
            
        default:
            break;
    }
}
//datePicker监听方法
-(void)didSelectTime:(UIDatePicker *)sender
{
    //创建格式化时间对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //设置格式化时间的对象的样式
    formatter.dateFormat = @"YYY-MM-dd";
    //通过格式化对象，将时间格式转换成字符串
    NSString *str = [formatter stringFromDate:sender.date];
    //给输入框赋值
    self.time.text = str;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//禁止输入框与用户交互
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    return NO;
//}
//返回NO不能在输入框输入文字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}

@end
