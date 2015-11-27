//
//  Teacher.h
//  04-归档解档
//
//  Created by 何建新 on 15/11/20.
//  Copyright © 2015年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Teacher : NSObject<NSCoding>
@property(nonatomic, copy)NSString *name;
@property(nonatomic, assign)int age;
@end
