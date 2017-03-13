//
//  HHResponderDView.m
//  studyDemo
//
//  Created by hanhu on 2017/3/13.
//  Copyright © 2017年 hh. All rights reserved.
//

#import "HHResponderDView.h"

@implementation HHResponderDView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSLog(@"进入D_View---hitTest withEvent ---");
    UIView * view = [super hitTest:point withEvent:event];
    NSLog(@"离开D_View--- hitTest withEvent ---hitTestView:%@",view);
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    NSLog(@"D_view--- pointInside withEvent ---");
    BOOL isInside = [super pointInside:point withEvent:event];
    NSLog(@"D_view--- pointInside withEvent --- isInside:%d",isInside);
    return isInside;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"D_touchesBegan");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"D_touchesMoved");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    NSLog(@"D_touchesEnded");
}

@end
