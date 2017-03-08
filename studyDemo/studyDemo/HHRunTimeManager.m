//
//  HHRunTimeManager.m
//  studyDemo
//
//  Created by hanhu on 2017/3/8.
//  Copyright © 2017年 hh. All rights reserved.
//

#import "HHRunTimeManager.h"


@implementation HHRunTimeManager

/**
 *获取类名
 *
 *@param class 传入的类
 *@return NSString 返回的类名
 *
 */
+ (NSString *)returnClassName:(Class)class{
    //获取类名
    const char *className = object_getClassName(class);
    return [NSString stringWithUTF8String:className];
}

/**
 *获取成员变量
 *
 *@param class 传入的类
 *@return NSArray 返回的类的成员变量列表
 *
 */

+ (NSArray *)returnIvarList:(Class)class{
    //调用方法，获取成员列表
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0 ; i < count; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dict[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        dict[@"type"] = [NSString stringWithUTF8String:ivarType];
        [mutableList addObject:dict];
    }
    
    //记得free掉 ivarList
    free(ivarList);
    
    return [NSArray arrayWithArray:mutableList];
    
}

/**
 *获取类的实例方法列表
 *
 *@param class 传入的类
 *@return NSArray 返回的类的实例方法列表
 *
 */
+ (NSArray *)returnInstanceMethod:(Class)class{
    //获取实例方法列表
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 *获取类的类方法列表
 *
 *@param class 传入的类
 *@return NSArray 返回的类的类方法列表
 *
 */
+ (NSArray *)returnClassList:(Class)class{
    //获取类方法
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(object_getClass(class), &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
    
}

/**
 *获取类的属性列表
 *
 *属性的结构体中包含name,value
 *
 *@param class 传入的类
 *@return NSArray 返回的类的属性列表
 *
 */
+ (NSArray *)returnPropertyList:(Class)class{
    //获取属性列表
    unsigned int count = 0 ;
    objc_property_t *propertyList = class_copyPropertyList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 *获取类的协议列表
 *
 *@param class 传入的类
 *@return NSArray 返回的类的协议列表
 *
 */
+ (NSArray *)returnProtocolList:(Class)class{
    //获取协议列表
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(class, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String:protocolName]];
    }
    free(protocolList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 *为类增加实例方法
 *
 *@param class 传入的类
 *@param methodSel methodSEL
 *
 */
+ (void)addInstanceMethod:(Class)class method:(SEL)methodSel fromClass:(Class)source{
   
    Method method = class_getInstanceMethod(source, methodSel);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, types);
}

/**
 *为类增加类方法
 *
 *@param class 传入的类
 *@param methodSel methodSEL
 *
 */
+ (void)addClassMethod:(Class)class method:(SEL)methodSel fromClass:(Class)source{
    
    Method method = class_getClassMethod(source, methodSel);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(class, methodSel, methodIMP, types);
}

/**
 *类中两个实例方法交换
 *
 *@param class 传入的类
 *@param methodOne 方法1
 *@param methodTwo 方法2
 *
 */
+ (void)instanceMethodSwap:(Class)class firstMethod:(SEL)methodOne secondMethod:(SEL)methodTwo{
    
    Method firstMethod = class_getInstanceMethod(class, methodOne);
    Method secondMethod = class_getInstanceMethod(class, methodTwo);
    method_exchangeImplementations(firstMethod, secondMethod);
    
}

/**
 *类中两个实例方法交换
 *
 *@param class 传入的类
 *@param methodOne 方法1
 *@param methodTwo 方法2
 *
 */
+ (void)classMethodSwap:(Class)class firstMethod:(SEL)methodOne secondMethod:(SEL)methodTwo{
    
    Method firstMethod = class_getClassMethod(class, methodOne);
    Method secondMethod = class_getClassMethod(class, methodTwo);
    method_exchangeImplementations(firstMethod, secondMethod);
}

/**
 *类中实例方法替换
 *
 *@param class 传入的类
 *@param methodBefore 方法1
 *@param methodAfter 方法2
 *
 *@note 方法1将会被方法2替换
 */
+ (void)instanceMethodReplace:(Class)class firstMethod:(SEL)methodBefore secondMethod:(SEL)methodAfter fromClass:(Class)source{
    
    Method secondMethod = class_getInstanceMethod(source, methodAfter);
    IMP secondIMP = method_getImplementation(secondMethod);
    const char *types = method_getTypeEncoding(secondMethod);
    
    class_replaceMethod(class, methodBefore, secondIMP, types);
   

}

@end
