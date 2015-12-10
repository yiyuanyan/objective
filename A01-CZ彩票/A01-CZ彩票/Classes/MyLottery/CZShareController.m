//
//  CZShareController.m
//  A01-CZ彩票
//
//  Created by 何建新 on 15/12/10.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import "CZShareController.h"
#import <MessageUI/MessageUI.h>
@interface CZShareController () <MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>
@property(nonatomic, strong)UIWebView *webView;
@end

@implementation CZShareController
-(UIWebView *)webView
{
    if (_webView == nil) {
        _webView = [[UIWebView alloc]init];
    }
    return _webView;
}
-(void)setData
{
    //__weak CZShareController *weakSelf = self;
    __weak typeof (self) weakSelf = self;
    CZItem *item1 = [CZItemArrow itemWithTitle:@"电话分享" icon:nil option:^{
        //协议telprompt能打完电话回到当前应用。但会有打电话提示。APP审核可能不会通过所以尽量用tel协议
//        NSURL *url = [NSURL URLWithString:@"tel://18600562546"];
//        [[UIApplication sharedApplication] openURL:url];
        NSURL *url = [NSURL URLWithString:@"tel:/10086"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [weakSelf.webView loadRequest:request];
    }];
    CZItem *item2 = [CZItemArrow itemWithTitle:@"短信分享" icon:nil option:^{
        if (![MFMessageComposeViewController canSendText]) {
            return ;
        }
        MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc]init];
        vc.recipients = @[@"10086"];
        vc.body = @"推荐一个游戏给你";
        vc.subject = @"标题";
        //设置代理
        vc.messageComposeDelegate = weakSelf;
        [weakSelf presentViewController:vc animated:YES completion:nil];
    }];
    CZItem *item3 = [CZItemArrow itemWithTitle:@"邮件分享" icon:nil option:^{
        //判断是否能发送邮件
        if (![MFMailComposeViewController canSendMail]) {
            return ;
        }
        MFMailComposeViewController *vc = [[MFMailComposeViewController alloc]init];
        vc.mailComposeDelegate = weakSelf;
        //设置收件人
        [vc setToRecipients:@[@"yiyuanhanly@126.com"]];
        //设置秘密发送人
        [vc setBccRecipients:@[@"yiyuanyan@126.com"]];
        //设置邮件标题
        [vc setSubject:@"发奖金啦"];
        //内容
        [vc setMessageBody:@"假的" isHTML:NO];
        //设置附件
        UIImage *image = [UIImage imageNamed:@"aa"];
        NSData *data = UIImagePNGRepresentation(image);
        [vc addAttachmentData:data mimeType:@"image/png" fileName:@"照片.png"];
        
        
    }];
    CZGroup *group = [CZGroup groupWithItems:@[item1,item2,item3]];
    self.groups = @[group];
}


-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}
@end
