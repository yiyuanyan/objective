//
//  ViewController.m
//  QQ聊天
//
//  Created by 何建新 on 15/10/28.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "ViewController.h"
#import "CZMessage.h"
#import "CZMessageFrame.h"
#import "CZMessageCell.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    //让控制器称为textField的代理
    self.textField.delegate = self;
    //隐藏分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //设置tableView的颜色
    self.tableView.backgroundColor = [UIColor colorWithRed:240.0 / 255.0 green:240.0 / 255.0 blue:240.0 / 255.0 alpha:1];
    
    //调整输入框光标位置
    self.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    //监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboarWillChangeNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
#pragma mark - 键盘通知回调方法
-(void)keyboarWillChangeNotification:(NSNotification *)notification
{
    //取出键盘开始和结束的Y坐标
    //1.取出键盘当前的Y坐标
    CGRect beginFrame = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //两次状态的Y的差值
    CGFloat minus =  endFrame.origin.y - beginFrame.origin.y;
    //取出当前view的Y
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += minus;
    self.view.frame = viewFrame;
    
}
#pragma mark - 隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark - tableView数据源方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageFrames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建cell
    CZMessageCell *cell = [CZMessageCell messageCellWithTableView:tableView];
    //设置数据
    cell.messageFrame = self.messageFrames[indexPath.row];
    return cell;
}

#pragma mark - tableView代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取出frame模型
    CZMessageFrame *messageFrame = self.messageFrames[indexPath.row];
    return messageFrame.rowHeight;
}
/**
 *  拖拽tableView方法
 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //推出键盘
    [self.view endEditing:YES];
}
#pragma mark - textField代理方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendMessageWithText:textField.text andMessageType:CZMessageTypeMe];
    //自动回复
    [self sendMessageWithText:@"滚" andMessageType:CZMessageTypeOther];
    self.textField.text = nil;
    return YES;
}
//发送消息代码
-(void)sendMessageWithText:(NSString *)text andMessageType:(CZMessageType )type
{
    NSString *newMessage = text;
    CZMessage *message = [[CZMessage alloc] init];
    message.text = newMessage;
    message.type = type;
    //创建当前时间
    NSDate *now = [NSDate date];
    //时间转字符串
    //创建日期格式化类，把日期转为字符串或字符串转日期
    NSDateFormatter *ftm = [[NSDateFormatter alloc]init];
    //设置日期格式
    ftm.dateFormat = @"HH:mm";
    message.time = [ftm stringFromDate:now];
    //处理隐藏时间
    //
    //取出最后一条数据
    CZMessageFrame *preMessageFrame = [self .messageFrames lastObject];
    //如果上一条数据和当前发送的时间相同，则隐藏时间
    if ([message.time isEqualToString:preMessageFrame.message.time]) {
        message.hideTime = YES;
    }
    //数据模型转换为frame模型
    CZMessageFrame *frame = [[CZMessageFrame alloc]init];
    frame.message = message;
    //添加到数组中
    [self.messageFrames addObject:frame];
    //刷新表格
    [self.tableView reloadData];
    //让tableView滚到最后一行
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
#pragma mark - 懒加载
-(NSMutableArray *)messageFrames
{
    //1.只有没有数据才加载
    if (_messageFrames == nil) {
        //取出数据模型
        NSArray *array = [CZMessage messages];
        //数据模型转为frame模型
        NSMutableArray *arrayM = [NSMutableArray array];
        for (CZMessage *message in array) {
            //取出上一条数据
            CZMessageFrame *lastMessageFrame = [arrayM lastObject];
            //上一条数据
            CZMessage *preMessage = lastMessageFrame.message;
            if ([message.time isEqualToString:preMessage.time]) {
                //两次发布的信息相等
                message.hideTime = YES;
            }
            //创建frame模型
            CZMessageFrame *messageFrame = [[CZMessageFrame alloc]init];
            //将数据赋值给模型
            messageFrame.message = message;
            //转换后的数据模型添加入可变数组
            [arrayM addObject:messageFrame];
        }
        //把frame模型的数组赋值给成员变量
        _messageFrames = arrayM;
    }
    return _messageFrames;
}

#pragma mark - dealloc方法
-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
