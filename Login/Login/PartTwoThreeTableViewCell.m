//
//  PartTwoThreeTableViewCell.m
//  Login
//
//  Created by 何建新 on 16/4/11.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoThreeTableViewCell.h"
#import "TMContent.h"

#define kScreenWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
@interface PartTwoThreeTableViewCell()
@property(nonatomic, strong)UIView *btnView;
@end
@implementation PartTwoThreeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier contentDic:(NSDictionary *)contentDic indexPath:(NSIndexPath*)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if(indexPath.section == 0){
            [self createQuest:contentDic[@"title"]];
            
        }
    }
    //中文答案Label
    CGFloat chHeight = [self stringHeight:TM.chines];
    UILabel *chLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth-10, chHeight+5)];
    chLabel.font = [UIFont systemFontOfSize:14];
    chLabel.text = TM.chines;
    chLabel.numberOfLines = 0;
    chLabel.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    chLabel.hidden = !TM.state;
    UIView *chView = [[UIView alloc] initWithFrame:CGRectMake(0, self.btnView.frame.origin.y+45, kScreenWidth, chLabel.frame.size.height+5)];
    chView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    
    chView.hidden = !TM.state;
    [chView addSubview:chLabel];
    //if(!TM.state){
        [self.contentView addSubview:chView];
    //}
    [self.contentView addSubview:enLabel];
    [self.contentView addSubview:self.btnView];
    
}
//录音播放方法
-(void)luyinPlay:(UIButton *)sender{
    self.luyinPlayBtn (self.luyinFilePath,self.luyinIndexPath);
}
-(void)clickBtn:(UIButton *)sender{

    self.clickButton (self.index);
    
}
//录音
-(void)luyinBtn:(UIButton *)sender{
    self.luyinButton (self.cellId);
    self.luyinAnimation (self.btnView,self.luyinAnimationIndexPath);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)createQuest:(NSString *)string{
    CGFloat height = [self getStringSize:string];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];
    textView.text = string;
    textView.userInteractionEnabled = NO;
    textView.scrollEnabled = NO;
    UITextView *testView = [[UITextView alloc] initWithFrame:CGRectMake(0, height, [UIScreen mainScreen].bounds.size.width, height)];
    testView.userInteractionEnabled = NO;
    testView.text = string;
    testView.scrollEnabled = NO;
    
    
    [self.contentView addSubview:textView];
    if(self.hindex == 0){
        [self.contentView addSubview:testView];
    }
}
-(CGFloat)getStringSize:(NSString *)string{
    UIFont *strFont = [UIFont fontWithName:@"Arial" size:14];
    CGSize strSize = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
    return strSize.height;
}
@end
