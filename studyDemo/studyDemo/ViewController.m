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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, copy) NSArray *datas;

@end

@implementation ViewController


#pragma mark - ViewControllerLifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.datas = @[@"runtime",@"runloop",@"GCD",@"动画",@"KVO&&KVC",@"NSOperation",@"存储"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.table deselectRowAtIndexPath:[self.table indexPathForSelectedRow] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:self.datas[indexPath.row] sender:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewBaseCell"];
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}



@end
