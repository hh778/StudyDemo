//
//  HHResponderLinkViewController.m
//  studyDemo
//
//  Created by hanhu on 2017/3/13.
//  Copyright © 2017年 hh. All rights reserved.
//
//  事件分发和响应者链
//
//  当用户点击了屏幕上的视图，应用是如何做出响应的呢？这里主要通过事件分发和响应者链来达到目的。
//
//  1.用户点击视图后，发生了触摸事件，系统会将这个事件放到事件队列中，当排到它的时候，就会对其进行事件分发，找到接受这个事件的视图。
//    事件的分发是由父视图向子视图传递，及从UIApplication开始到UIWindw到UIView再到各个子视图；
//    如何查找的呢：调用hitTest:WithEvent:方法I，首先判断自己是否能接收事件，如果能就继续判断，不能，就停止该视图及其子视图的事件分发；II，调用pointInside:withEvent: 返回触摸点是否在视图内，如果是，再递归检查该视图的子视图(从最上面的子视图开始)，直到找到最初的应该响应事件的视图，到此事件分发完毕,不是，该视图及其子视图线路结束；
//
// The implementation of hitTest:withEvent: in UIResponder does the following:

// It calls pointInside:withEvent: of self
// If the return is NO, hitTest:withEvent: returns nil. the end of the story.
// If the return is YES, it sends hitTest:withEvent: messages to its subviews. it starts from the top-level subview, and continues to other views until a subview returns a non-nil object, or all subviews receive the message.
// If a subview returns a non-nil object in the first time, the first hitTest:withEvent: returns that object. the end of the story.
// If no subview returns a non-nil object, the first hitTest:withEvent: returns self
//
//
//
//  当找到了这个视图后，开始事件的响应，从最初始的响应者开始，调用
//  touchBegin:WithEvent:  touchMove:WithEvent: touchEnd:WithEvent:,依次进行响应，响应不了就传给下一个响应者，知道UIApplication 如果也响应不了，则会丢弃该事件
//
//
//  
//  通过重载hitTest:WithEvent:方法，可以扩大视图的点击事件相应范围

#import "HHResponderLinkViewController.h"

@interface HHResponderLinkViewController ()

@end

@implementation HHResponderLinkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
