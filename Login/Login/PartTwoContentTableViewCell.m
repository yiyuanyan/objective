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
-(void)setPart2Dic:(NSMutableDictionary *)part2Dic{
    _part2Dic = part2Dic;
    self.enStr = self.part2Dic[@"p2_english"];
    self.chStr = self.part2Dic[@"p2_chines"];
}
-(void)enLabel:(NSString *)enString{
    NSLog(@"%@",enString);
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
