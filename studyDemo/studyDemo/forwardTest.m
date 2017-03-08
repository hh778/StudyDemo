//
//  forwardTest.m
//  studyDemo
//
//  Created by hanhu on 2017/3/8.
//  Copyright © 2017年 hh. All rights reserved.
//

#import "forwardTest.h"
#import <objc/runtime.h>
#import "subForwardTest.h"

@implementation forwardTest

- (NSString *)forwardTest{
    return @"消息转发二段成功";
}

- (NSString *)resolveInstance{
    return  @"动态方法决议成功";
}


#pragma mark - messageForward
//动态决策
+ (BOOL)resolveClassMethod:(SEL)sel{
    return [super resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    //将方法动态添加到类中，达成动态决策
    if (sel == @selector(noMethod)) {
        
        Method method = class_getInstanceMethod([self class], @selector(resolveInstance));
        
        class_addMethod([self class], sel,method_getImplementation(method),method_getTypeEncoding(method));
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}
//动态决策失败，启动快速转发，只可以发送给一个可以响应这个消息的对象
- (id)forwardingTargetForSelector:(SEL)aSelector{
    
    if (aSelector == @selector(noMethodToo)) {
        //返回可以响应方法的对象
        subForwardTest *test = [[subForwardTest alloc]init];
        if ([test respondsToSelector:aSelector]) {
            return test;
        }
    }
    
    return [super forwardingTargetForSelector:aSelector];
}
//快速转发失败，启动标准转发，可以转发给多个对象
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    subForwardTest *test = [[subForwardTest alloc]init];
    
    if ([super respondsToSelector:aSelector]) {
       return [super methodSignatureForSelector:aSelector];
    }else if ([test respondsToSelector:aSelector]){//将对象生成的方法签名返回
        return [test methodSignatureForSelector:aSelector];
    }else{
        return [super methodSignatureForSelector:aSelector];
    }
    
}
//根据返回的方法签名，进行相应操作
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    SEL sel = [anInvocation selector];
    
    if (sel == @selector(noMethodAgain)) {
        subForwardTest *test = [[subForwardTest alloc]init];
        [anInvocation invokeWithTarget:test];
    }else{
        [super forwardInvocation:anInvocation];
    }
    
    
}

- (void)doesNotRecognizeSelector:(SEL)aSelector{
    
    [super doesNotRecognizeSelector:aSelector];
}


@end
