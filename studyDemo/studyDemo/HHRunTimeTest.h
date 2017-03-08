//
//  HHRunTimeTest.h
//  studyDemo
//
//  Created by hanhu on 2017/3/8.
//  Copyright © 2017年 hh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HHRunTimeTest : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *hobbys;

+ (NSString *)classMethodOne;
+ (NSString *)classMethodTwo;
- (NSString *)instanceMethodOne;
- (NSString *)instanceMethodTwo;

@end
