//
//  CZAppCell.m
//  应用管理
//
//  Created by 何建新 on 15/11/4.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZAppCell.h"
@interface CZAppCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadBtn;
@property (weak, nonatomic) IBOutlet UILabel *downloadLabel;
- (IBAction)download:(UIButton *)sender;

@end


@implementation CZAppCell

-(void)setApp:(CZApp *)app
{
    _app = app;
    self.iconView.image = [UIImage imageNamed:app.icon];
    self.nameLabel.text = app.name;
    self.downloadLabel.text = [NSString stringWithFormat:@"%@|%@",app.size,app.download];
}

- (IBAction)download:(UIButton *)sender {
    sender.enabled = NO;
    //定义代理
    if ([self.delegate respondsToSelector:@selector(appCellDownLoad:downloadAppBtn:)]) {
        [self.delegate appCellDownLoad:self downloadAppBtn:self.downloadBtn];
    }
}
@end
