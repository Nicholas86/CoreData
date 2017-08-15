//
//  StudentViewController.h
//  LessonCoreData
//
//  Created by lanouhn on 15/9/10.
//  Copyright (c) 2015年 王战胜. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Teacher;
@interface StudentViewController : UITableViewController
//学生的老师
@property (nonatomic,strong) Teacher *teacher;
//数据管理器
@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@end
