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
//创建问题Cell
-(void)createTitleCell:(NSString *)titleString TM:(TMContent *)TM indexPath:(NSIndexPath *)indexPath{

    //获取文字高度
    CGFloat strHeight = [self stringHeight:titleString];
    //文字Label
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth-10, strHeight+5)];
    titleLabel.text = titleString;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:14];
    //播放和录音按钮
    UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-53, 5, 33, 33)];
    [playBtn setImage:[UIImage imageNamed:@"play_press"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
    UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-103, 5, 33, 33)];
    [luyinBtn setImage:[UIImage imageNamed:@"luyin_press"] forState:UIControlStateNormal];
    [luyinBtn setImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateHighlighted];
    
    self.btnView = [[UIView alloc] initWithFrame:CGRectMake(0, titleLabel.frame.size.height, kScreenWidth, 44)];
    self.btnView.backgroundColor = [UIColor redColor];
    [self.btnView addSubview:playBtn];
    [self.btnView addSubview:luyinBtn];
    
    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:self.btnView];
    
}
//创建Part2List的Cell
-(void)createPart2ListCell:(TMContent *)TM indexPath:(NSIndexPath*)indexPath{
    self.index = indexPath;
    self.cellId = TM.cellId;
    self.luyinAnimationIndexPath = indexPath;
    //英文答案Label
    CGFloat enHeight = [self stringHeight:TM.english];
    UILabel *enLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, kScreenWidth-10, enHeight+5)];
    enLabel.font = [UIFont systemFontOfSize:14];
    enLabel.text = TM.english;
    enLabel.numberOfLines = 0;
    //播放和录音按钮
    UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-53, 5, 33, 33)];
    [playBtn setImage:[UIImage imageNamed:@"play_press"] forState:UIControlStateNormal];
    [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateHighlighted];
    UIButton *luyinBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-103, 5, 33, 33)];
    [playBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [luyinBtn setImage:[UIImage imageNamed:@"luyin_press"] forState:UIControlStateNormal];
    [luyinBtn setImage:[UIImage imageNamed:@"luyin"] forState:UIControlStateHighlighted];
    [luyinBtn addTarget:self action:@selector(luyinBtn:) forControlEvents:UIControlEventTouchUpInside];
    //播放录音按钮
    //查找录音文件是否存在
    NSString *fileName = [NSString stringWithFormat:@"%@.caf",self.cellId];
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL file = [fileManager fileExistsAtPath:path];
    self.btnView = [[UIView alloc] initWithFrame:CGRectMake(0, enLabel.frame.size.height, kScreenWidth, 44)];
    [self.btnView addSubview:playBtn];
    [self.btnView addSubview:luyinBtn];
    //录音文件存在则创建并加载进btnView中
    if(file){
        UIButton *luyinPlayBtn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth-153, 5, 33, 33)];
        [luyinPlayBtn setImage:[UIImage imageNamed:@"listen_press"] forState:UIControlStateNormal];
        [luyinPlayBtn setImage:[UIImage imageNamed:@"listen"] forState:UIControlStateHighlighted];
        self.luyinFilePath = path;
        self.luyinIndexPath = indexPath;
        [luyinPlayBtn addTarget:self action:@selector(luyinPlay:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnView addSubview:luyinPlayBtn];
        
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
//计算文字高度
-(CGFloat)stringHeight:(NSString *)string{
    UIFont *font = [UIFont systemFontOfSize:14];
    NSDictionary *attr = @{NSFontAttributeName:font};
    CGRect strRect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    return CGRectGetHeight(strRect);
    
}
@end
