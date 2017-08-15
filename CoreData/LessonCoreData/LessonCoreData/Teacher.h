//
//  Teacher.h
//  LessonCoreData
//
//  Created by lanouhn on 15/10/7.
//  Copyright (c) 2015年 王战胜. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Student;

@interface Teacher : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *studentship;
@end

@interface Teacher (CoreDataGeneratedAccessors)

- (void)addStudentshipObject:(Student *)value;
- (void)removeStudentshipObject:(Student *)value;
- (void)addStudentship:(NSSet *)values;
- (void)removeStudentship:(NSSet *)values;

@end
