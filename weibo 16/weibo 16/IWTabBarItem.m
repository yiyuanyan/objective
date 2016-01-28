//
//  IWTabBarItem.m
//  weibo 16
//
//  Created by 何建新 on 16/1/26.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import "IWTabBarItem.h"
#import <objc/runtime.h>
@implementation IWTabBarItem
-(void)setBadgeValue:(NSString *)badgeValue
{
    [super setBadgeValue:badgeValue];
    
    UITabBarController *tabBarCtrl = [self valueForKeyPath:@"_target"];
    for (UIView *tabBarChild in tabBarCtrl.tabBar.subviews) {
        if ([tabBarChild isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *tabBarButtonChild in tabBarChild.subviews) {
                if ([tabBarButtonChild isKindOfClass:NSClassFromString(@"_UIBadgeView")]) {
                    for (UIView * badgeViewChild in tabBarButtonChild.subviews) {
                        if ([badgeViewChild isKindOfClass:NSClassFromString(@"_UIBadgeBackground")]) {
                            NSLog(@"终于找到你，还好没放弃");
                            NSLog(@"%@",badgeViewChild);
                            //badgeViewChild.backgroundColor = [UIColor blackColor];
                            //虽然找到了，不知道设置其身上什么值去更改那个大红色
                            //有没有相关的方法去获取其身上的属性再看看
                            
                            
                            
                            
                            unsigned int count;
                            //获取某个类身上的所有属性
                            Ivar *ivars = class_copyIvarList([badgeViewChild class], &count);
                            
                            for (int i = 0; i < count; i++) {
                                Ivar ivar = ivars[i];
                                
                                //获取属性的名字
                                NSString *ivarName = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
                                //获取属性的类型
                                NSString *ivarType = [NSString stringWithCString:ivar_getTypeEncoding(ivar) encoding:NSUTF8StringEncoding];
                                
                                NSLog(@"%@:%@",ivarName,ivarType);
                                //判断如果当前是_image属性
                                if ([ivarName isEqualToString:@"_image"]) {
                                    
                                    UIImage *image = [UIImage imageNamed:@"main_badge"];
                                    //通过kvc去设置某个对象身上的某个属性的值
                                    [badgeViewChild setValue:image forKeyPath:@"image"];
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
@end
