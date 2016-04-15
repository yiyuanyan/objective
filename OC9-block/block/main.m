//
//  main.m
//  block
//
//  Created by 何建新 on 16/4/7.
//  Copyright © 2016年 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        //定义block变量，并且赋值
//        void (^myBlock)() = ^{
//            NSLog(@"Hello World");
//        };
//        //使用block
//        myBlock();
        //定义一个没有返回值没有参数的block的别名，^Block现在是类型
        typedef void (^Block)();
        Block b1; //定义一个Block类型的变量
        b1=^{
            NSLog(@"Block的b1");
        };
        //调用Block的类型b1
        b1();
        
        //定义带参数带返回值的Block
        typedef int (^NewType)(int ,int);
        NewType nt1 = ^(int a, int b){
            return a+b;
        };
        int s = nt1(12,23);
        NSLog(@"%d",s);
    }
    return 0;
}
