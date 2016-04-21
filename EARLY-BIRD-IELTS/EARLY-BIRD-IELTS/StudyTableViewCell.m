//
//  StudyTableViewCell.m
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/15.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "StudyTableViewCell.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kStrFont [UIFont fontWithName:@"Arial" size:14]
@implementation StudyTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    return self;
}
-(void)setDic:(NSMutableDictionary *)dic
{
    _dic = dic;
}
-(void)createCell{
    //获取文字宽度和高度
    float btnStrWidth = [self getStringWidth:self.dic[@"categoryname_e"] strFont:kStrFont returnWidth:YES returnHeight:NO];
    //问题label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, kScreenWidth-80, 40)];
    label.font = kStrFont;
    label.text = self.dic[@"problem"];
    //栏目按钮
    UIButton *cateBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-30-btnStrWidth, 5, btnStrWidth+20, 30)];
    cateBtn.font = kStrFont;
    [cateBtn setTitle:self.dic[@"categoryname_e"] forState:UIControlStateNormal];
    [cateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cateBtn.layer setMasksToBounds:YES];
    [cateBtn.layer setCornerRadius:15.0];
    [cateBtn.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    [cateBtn.layer setBorderColor:CGColorCreate(colorSpace,(CGFloat[]){ 0.8, 0.8, 0.8, 0.8 })];
    [cateBtn addTarget:self action:@selector(cateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cateBtn];
    [self.contentView addSubview:label];
}
-(void)cateBtnClick:(UIButton *)sender{
    NSLog(@"栏目ID是：%@",self.dic[@"cateid"]);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 *  获取字符串宽度或高度
 *
 *  @param string       要获取宽度的字符串
 *  @param fontSize     字符串的字体大小
 *
 *  @return 字符串的宽度或高度
 */
-(CGFloat)getStringWidth:(NSString *)string strFont:(UIFont *)strFont returnWidth:(BOOL)returnWidth returnHeight:(BOOL)returnHeight
{
    //    CGSize sizeToFit = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(CGFLOAT_MAX, stringHeight) lineBreakMode:NSLineBreakByWordWrapping];
    //    return sizeToFit.width;
    
    CGSize strSize = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:strFont} context:nil].size;
    if (returnWidth == YES) {
        return strSize.width;
    }else if (returnHeight == YES) {
        return strSize.height;
    }else{
        return 0;
    }
}
@end
