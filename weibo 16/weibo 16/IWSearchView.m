//
//  IWSearchView.m
//  weibo 16
//
//  Created by 何建新 on 16/1/20.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWSearchView.h"
@interface IWSearchView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end
@implementation IWSearchView

+(instancetype)searchView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"IWSearchView" owner:nil options:nil] lastObject];
}

-(void)awakeFromNib
{
    //设置textField的leftView的图片
    UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
    leftView.contentMode = UIViewContentModeCenter;
    leftView.width = 35;
    
    self.searchField.leftView = leftView;
    //设置textField的leftViewMode的显示方法。显示图片
    self.searchField.leftViewMode = UITextFieldViewModeAlways;
    self.searchField.delegate = self;
    //设置圆角
//    self.searchField.layer.cornerRadius = 5;
//    self.searchField.layer.masksToBounds = YES;
    self.searchField.layer.borderColor = nil;
    self.searchField.layer.borderWidth = 1;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //textField开始编辑的时候，会回调这个方法
    NSLog(@"%s",__func__);
    //更新约束，代表重新布局，如果要执行动画，就把重新布局的代码放在动画的block里面
    self.rightConstraint.constant = self.cancelButton.size.width;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}
- (IBAction)cancelBtnClick:(UIButton *)sender {
    self.rightConstraint.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];
    //清除搜索框选中状态
    [self.searchField resignFirstResponder];
}


@end
