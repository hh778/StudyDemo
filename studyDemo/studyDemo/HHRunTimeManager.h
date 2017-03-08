//
//  HHRunTimeManager.h
//  studyDemo
//
//  Created by hanhu on 2017/3/8.
//  Copyright © 2017年 hh. All rights reserved.
//


/**
 
 runtime里可以看到对于class的定义，每个class里包含一个isa指针，指向类对象；同时还包含父类名，本类名，成员变量列表，方法列表，方法缓存，协议列表等信息。以便于在运行时，进行相关信息的查找，匹配。
 
 struct objc_class {
 Class isa  OBJC_ISA_AVAILABILITY;
 
 #if !__OBJC2__
 Class super_class                                        OBJC2_UNAVAILABLE;
 const char *name                                         OBJC2_UNAVAILABLE;
 long version                                             OBJC2_UNAVAILABLE;
 long info                                                OBJC2_UNAVAILABLE;
 long instance_size                                       OBJC2_UNAVAILABLE;
 struct objc_ivar_list *ivars                             OBJC2_UNAVAILABLE;
 struct objc_method_list **methodLists                    OBJC2_UNAVAILABLE;
 struct objc_cache *cache                                 OBJC2_UNAVAILABLE;
 struct objc_protocol_list *protocols                     OBJC2_UNAVAILABLE;
 #endif
 
 } OBJC2_UNAVAILABLE;
 
 */
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface HHRunTimeManager : NSObject

/**
 *获取类名
 *
 *@param class 传入的类
 *@return NSString 返回的类名
 *
 */
+ (NSString *)returnClassName:(Class)class;

/**
 *获取成员变量
 *
 *@param class 传入的类
 *@return NSArray 返回的类的成员变量列表
 *
 */
+ (NSArray *)returnIvarList:(Class)class;

/**
 *获取类的实例方法列表
 *
 *@param class 传入的类
 *@return NSArray 返回的类的实例方法列表
 *
 */
+ (NSArray *)returnInstanceMethod:(Class)class;

/**
 *获取类的类方法列表
 *
 *@param class 传入的类
 *@return NSArray 返回的类的类方法列表
 *
 */
+ (NSArray *)returnClassList:(Class)class;

/**
 *获取类的属性列表
 *
 *@param class 传入的类
 *@return NSArray 返回的类的属性列表
 *
 */
+ (NSArray *)returnPropertyList:(Class)class;

/**
 *获取类的协议列表
 *
 *@param class 传入的类
 *@return NSArray 返回的类的协议列表
 *
 */
+ (NSArray *)returnProtocolList:(Class)class;//172940

/**
 *为类增加实例方法
 *
 *@param class 传入的类
 *@param methodSel methodSEL
 *
 */
+ (void)addInstanceMethod:(Class)class method:(SEL)methodSel fromClass:(Class)source;

/**
 *为类增加类方法
 *
 *@param class 传入的类
 *@param methodSel methodSEL
 *
 */
+ (void)addClassMethod:(Class)class method:(SEL)methodSel fromClass:(Class)source;

/**
 *类中两个实例方法交换
 *
 *@param class 传入的类
 *@param methodOne 方法1
 *@param methodTwo 方法2
 *
 */
+ (void)instanceMethodSwap:(Class)class firstMethod:(SEL)methodOne secondMethod:(SEL)methodTwo;

/**
 *类中两个类方法交换
 *
 *@param class 传入的类
 *@param methodOne 方法1
 *@param methodTwo 方法2
 *
 */
+ (void)classMethodSwap:(Class)class firstMethod:(SEL)methodOne secondMethod:(SEL)methodTwo;

/**
 *类中实例方法替换
 *
 *@param class 传入的类
 *@param methodBefore 方法1
 *@param methodAfter 方法2
 *
 *@note 方法1将会被方法2替换
 */
+ (void)instanceMethodReplace:(Class)class firstMethod:(SEL)methodBefore secondMethod:(SEL)methodAfter fromClass:(Class)source;


@end
