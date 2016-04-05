//
//  PartTwoThreeTableViewCell.m
//  Login
//
//  Created by 何建新 on 16/4/3.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "PartTwoThreeTableViewCell.h"

@implementation PartTwoThreeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier contentDic:(NSDictionary *)contentDic indexPath:(NSIndexPath*)indexPath{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if(indexPath.section == 0){
            NSLog(@"%@",contentDic);
            [self createQuest:contentDic[@"title"]];
        }
    }
    

    return self;
    
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
    
    [self.contentView addSubview:textView];
}
-(CGFloat)getStringSize:(NSString *)string{
    UIFont *strFont = [UIFont fontWithName:@"Arial" size:14];
    CGSize strSize = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
    return strSize.height;
}
@end
