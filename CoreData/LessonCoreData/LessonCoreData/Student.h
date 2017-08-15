//
//  Student.h
//  LessonCoreData
//
//  Created by lanouhn on 15/10/7.
//  Copyright (c) 2015年 王战胜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Teacher;

@interface Student : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * girl;
@property (nonatomic, retain) NSString * man;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) NSNumber * attribute;
@property (nonatomic, retain) Teacher *teachership;

@end
