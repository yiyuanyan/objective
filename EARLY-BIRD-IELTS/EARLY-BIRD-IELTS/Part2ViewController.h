//
//  Part2ViewController.h
//  EARLY-BIRD-IELTS
//
//  Created by 何建新 on 16/4/27.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Part2ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *tableScrollView;

@end
