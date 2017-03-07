//
//  AppDelegate.m
//  studyDemo
//
//  Created by hanhu on 2017/3/7.
//  Copyright © 2017年 hh. All rights reserved.
//
//
//
//  application的生命周期
//  1.将要加载完成:willFinishLaunching
//  2.加载完成:didFinishLauching
//  3.已经处于激活状态:didBecomeActive
//  4.即将处于挂起暂停状态:willResignActive
//  5.已经进入后台状态：didEnterBackground
//  6.即将进入前台状态：willEnterForeground
//  7.退出：willTerminate
//
//  主要的生命周期包括上面这6种状态，
//  1.当应用初次运行的时候，会依次调用方法1，2，3；
//  2.当应用在前台时，接收到电话，短信，拉下通知栏时，调用方法4，使应用从激活状态转为暂停未激活状态；
//  3.当用户取消接听电话，或者将通知栏拉上去时，调用方法3，使应用重新进入激活状态；
//  4.当应用在前台，用户双击home键时，调用方法4，将应用由激活状态转为未激活状态
//  5.当用户按下Home键将应用退到后台时,或用户锁屏时，调用方法4，5，将应用从激活状态，变为未激活状态，并由前台转到后台运行
//  6.当用户再次切换到应用时，或用户开锁时(锁屏前应用在前台)，调用方法6，3，将应用转到前台，并处于激活状态
//  7.当用户退出应用时，依次调用方法4，5，7
//
//


#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"studyDemo"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
