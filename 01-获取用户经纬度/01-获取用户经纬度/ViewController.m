//
//  ViewController.m
//  01-获取用户经纬度
//
//  Created by 何建新 on 16/1/15.
//  Copyright © 2016年 何建新. All rights reserved.
//
//获取经纬度需要导入框架
#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property(nonatomic, strong)CLLocationManager *mgr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建定位管理
    self.mgr = [[CLLocationManager alloc]init];
    //设置定位代理为自身
    self.mgr.delegate = self;
    //开始定位
    [self.mgr startUpdatingLocation];
    [self caculateDistance];
}

//代理方法,locations为精度和维度的数组
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    //获取经度
    CLLocation *local = [locations firstObject];
    //停止定位,防止持续定位
    [self.mgr stopUpdatingLocation];
    CLLocationCoordinate2D coordinate = local.coordinate;
    //coordinate.latitude 纬度
    //coordinate.longitude 经度
    NSLog(@"纬度:%f,经度:%f",coordinate.latitude,coordinate.longitude);
}
//计算距离
-(void)caculateDistance{
    //获取用户两个点
    //北京
    CLLocation *local1 = [[CLLocation alloc]initWithLatitude:39.54 longitude:116.28];
    //深圳
    CLLocation *local2 = [[CLLocation alloc]initWithLatitude:22.27 longitude:113.46];
    
    //计算距离
    CLLocationDistance juli = [local2 distanceFromLocation:local1];
    NSLog(@"北京-深圳的距离是:%f",juli);
}
@end
