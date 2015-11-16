//
//  ViewController.m
//  键盘处理-练习
//
//  Created by 何建新 on 15/11/12.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "CZToolBar.h"
@interface ViewController ()<UITextFieldDelegate,CZToolBarDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.time.delegate = self;
    self.city.delegate = self;
    self.textFields = @[self.time, self.city];
    //创建DatePickerView，由于是输入框获取焦点时加入视图所以不用addSubView
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    
    //设置DatePicker为中文
    datePicker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    //设置DatePicker显示年月日
    datePicker.datePickerMode = UIDatePickerModeDate;
    //使用addTarget:方法创建监听事件
    [datePicker addTarget:self action:@selector(didSelectTime:) forControlEvents:UIControlEventValueChanged];
    //输入框获取焦点时加入视图datePicker
    self.time.inputView = datePicker;
    //创建自定义CZToolBar视图
    CZToolBar *toolBar = [CZToolBar toolBar];
    self.toolBar = toolBar;
    //设定toolBar视图代理
    toolBar.toolBarDelegate = self;
    //将toolBar加入辅助视图
    self.time.inputAccessoryView = toolBar;
    self.city.inputAccessoryView = toolBar;
}
//datePicker监听方法
-(void)didSelectTime:(UIDatePicker *)send
{
    //创建格式化时间对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设置格式化时间格式
    dateFormatter.dateFormat = @"YYYY-MM-dd";
    //将传递过来的date进行格式化成字符串
    NSString *date = [dateFormatter stringFromDate:send.date];
    //将格式化后的日期字符串赋值给self.time.text
    self.time.text = date;
}
//禁止在输入框中输入文字
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return NO;
}
#pragma mark -CZToolBar代理方法
-(void)toolBar:(CZToolBar *)toolBar didClickWithBtnType:(CZToolBarButtonType)type
{
    switch (type) {
        case CZToolBarButtonTypePre:
            [self.textFields[--_textFieldIndex] becomeFirstResponder];
            break;
        case CZToolBarButtonTypeNext:
            [self.textFields[++_textFieldIndex] becomeFirstResponder];
            break;
        case CZToolBarButtonTypeDone:
            [self.view endEditing:YES];
            break;
            
        default:
            break;
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    //获取被点击的输入框在全局变量输入框数组中第几个
    _textFieldIndex = [self.textFields indexOfObject:textField];
    //判断参数textField与全局变量textFields中哪个相等
    if ([[self.textFields firstObject] isEqual:textField]) {
        //第一个,关闭上一个按钮，打开下一个按钮
        self.toolBar.preButton.enabled = NO;
        self.toolBar.nextButton.enabled = YES;
    }else if ([[self.textFields lastObject] isEqual:textField]){
        self.toolBar.nextButton.enabled = NO;
        self.toolBar.preButton.enabled = YES;
    }
}
@end
