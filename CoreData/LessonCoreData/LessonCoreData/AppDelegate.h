//
//  AppDelegate.h
//  LessonCoreData
//
//  Created by lanouhn on 15/9/10.
//  Copyright (c) 2015年 王战胜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//数据管理器
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//数据模型器
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//数据链接器- (核心)
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//Coredata的核心思想:托管对象.
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end

