//
//  PartTwoContentTableViewCell.m
//  Login
//
//  Created by 何建新 on 16/3/31.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoContentTableViewCell.h"
@interface PartTwoContentTableViewCell()
@property(nonatomic, copy)NSString * enStr;
@property(nonatomic, copy)NSString *chStr;
@property(nonatomic, assign)CGFloat part2CellHeight;
@property(nonatomic, assign)CGFloat titleHeight;
@end
@implementation PartTwoContentTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
-(void)setTitle:(NSString *)title
{
    _title = title;
    if(self.indexPath.section == 0){
        CGFloat titleHeight = [self getStringSize:title];
        UITextView *titleTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, titleHeight)];
        titleTextView.text = self.title;
        titleTextView.userInteractionEnabled = NO;
        titleTextView.scrollEnabled = NO;
        /* 播放&录音按钮 */
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, titleTextView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 33)];
        
        UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-10-33, 0, 33, 33)];
        UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(playBtn.frame.origin.x-10-33, 0, 33, 33)];
        
        [playBtn setImage:[UIImage imageNamed:@"play_press.png"] forState:UIControlStateNormal];
        [playBtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateHighlighted];
        [luyinBtn setImage:[UIImage imageNamed:@"luyin_press.png"] forState:UIControlStateNormal];
        [luyinBtn setImage:[UIImage imageNamed:@"luyin.png"] forState:UIControlStateHighlighted];
        [btnView addSubview:playBtn];
        [btnView addSubview:luyinBtn];
        [self.contentView addSubview:titleTextView];
        [self.contentView addSubview:btnView];
        self.titleHeight = titleTextView.frame.size.height+btnView.frame.size.height;
    }
}
-(CGFloat)getTitleHeight{
    return self.titleHeight;
}
-(void)setPart2Dic:(NSMutableDictionary *)part2Dic{
    _part2Dic = part2Dic;
    if(self.indexPath.section == 1){
        CGFloat enHeight = [self getStringSize:self.part2Dic[@"p2_english"]];
        UITextView *enTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, enHeight)];
        enTextView.text = self.part2Dic[@"p2_english"];

        enTextView.userInteractionEnabled = NO;
        enTextView.scrollEnabled = NO;
        
        /* 播放&录音按钮
        UIView *btnView = [[UIView alloc] initWithFrame:CGRectMake(0, enTextView.frame.size.height, [UIScreen mainScreen].bounds.size.width, 33)];
        
        UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-10-33, 0, 33, 33)];
        UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(playBtn.frame.origin.x-10-33, 0, 33, 33)];
        
        [playBtn setImage:[UIImage imageNamed:@"play_press.png"] forState:UIControlStateNormal];
        [playBtn setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateHighlighted];
        [luyinBtn setImage:[UIImage imageNamed:@"luyin_press.png"] forState:UIControlStateNormal];
        [luyinBtn setImage:[UIImage imageNamed:@"luyin.png"] forState:UIControlStateHighlighted];
        [btnView addSubview:playBtn];
        [btnView addSubview:luyinBtn];
        /* 中文答案view
        CGFloat chHeight = [self getStringSize:self.part2Dic[@"p2_chines"]];
        UITextView *chTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, enTextView.frame.size.height+38, [UIScreen mainScreen].bounds.size.width, chHeight)];
        chTextView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        chTextView.text = self.part2Dic[@"p2_chines"];
        chTextView.userInteractionEnabled = NO;
        chTextView.scrollEnabled = NO;

        
        
        [self.contentView addSubview:btnView];
        [self.contentView addSubview:chTextView];*/
        [self.contentView addSubview:enTextView];
        self.part2CellHeight =  enTextView.frame.size.height+5;
    }
    
}
-(CGFloat)getPart2CellHeight{
    return self.part2CellHeight;
}
-(void)enLabel:(NSString *)enString{
    CGFloat enStringHeight = [self getStringSize:enString];
    UITextView *enTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, enStringHeight)];
    enTextView.text = enString;
    
    enTextView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:enTextView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(CGFloat)getStringSize:(NSString *)string{
    UIFont *strFont = [UIFont fontWithName:@"Arial" size:14];
    CGSize strSize = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
    return strSize.height;
}
@end
