//
//  AppDelegate.m
//  LessonCoreData
//
//  Created by lanouhn on 15/9/10.
//  Copyright (c) 2015年 王战胜. All rights reserved.
//

#import "AppDelegate.h"
#import "Student.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //路径
    NSLog(@"%@",NSHomeDirectory());
    //增删改查
    //创建对象,复杂方法
    //创建实体描述.
    /*
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    Student *student = [[Student alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    student.name = @"亚龙";
    [self saveContext];
    */
    //创建对象 简单方法.
    /*
    Student *student2 = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    student2.name = @"奇峰";
    student2.age = @18;
    student2.sex = @"男";
    [self saveContext];
    */
   // [self.managedObjectContext save:nil];
    //查询
    /*
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //设置检索条件
    //拼接检索条件,用and链接,或的话用or
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@ and age == %@",@"奇峰",@18];
    request.predicate = predicate;
    NSError *error = nil;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    Student *temStu = [array firstObject];
    NSLog(@"%@",temStu.name);
   */
    /*
    temStu.name = @"韩波";
    temStu.sex = @"女";
    temStu.age = @21;
    //保存
    [self.managedObjectContext save:nil];
    NSLog(@"学生名:%@",temStu.name);
    //改 无论是修改还是删除 都需要先查询 才能操作
    */
    //[self.managedObjectContext deleteObject:temStu];
   // [self saveContext];
     return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
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
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.lanou3g.doge.LessonCoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    //创建地址
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LessonCoreData" withExtension:@"momd"];
    //创建数据模型器
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    //创建数据连接器
    //指定了一个数据模型器
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    //创建了一个地址
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LessonCoreData.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    //第一个参数:NSSQLiteStoreType:数据格式.
    //1.是sql文件
    //2.xml文件
    //3.二进制文件
    //第二个参数:configuration:一些配置信息
    //第三个参数:URL:地址
    //第四个参数:options:一些选项,数据库升级,或者数据迁徙
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:@{NSMigratePersistentStoresAutomaticallyOption : @YES} error:&error]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //程序中断
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    //判断数据管理器是否存在.
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    //创建数据链接器
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    //判断数据连接器是否成功
    if (!coordinator) {
        return nil;
    }
    //创建一个数据管理器对象
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
