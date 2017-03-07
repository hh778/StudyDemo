//
//  ViewController.m
//  studyDemo
//
//  Created by hanhu on 2017/3/7.
//  Copyright © 2017年 hh. All rights reserved.
//
//  视图控制器生命周期:
//  1.loadView 加载视图
//  2.viewDidLoad 视图已经加载
//  3.viewWillAppear 视图控制器即将展示
//  4.viewDidAppear 视图控制器已经展示
//  5.viewWillDisappear 视图控制器即将不显示
//  6.viewDidDisappear 视图控制器已经不显示
//
//  当AB两个视图控制器进行切换时，例如已显示A视图，再展示B视图，则依次为A视图控制器将要消失，B视图控制器将要出现(如果是初次加载，需要有加载过程)，A视图控制器已经消失，B视图控制器已经出现。
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
