//
//  HHRunTimeTest.m
//  studyDemo
//
//  Created by hanhu on 2017/3/8.
//  Copyright © 2017年 hh. All rights reserved.
//

#import "HHRunTimeTest.h"

@implementation HHRunTimeTest{
    
    NSString *sex;
}

+ (NSString *)classMethodOne{
    return @"这是自带类方法ONE";
}

+ (NSString *)classMethodTwo{
    return @"这是自带类方法TWO";
}

- (NSString *)instanceMethodOne{
    return @"这是自带实例方法ONE";
}

- (NSString *)instanceMethodTwo{
    return @"这是自带实例方法TWO";
}

@end
