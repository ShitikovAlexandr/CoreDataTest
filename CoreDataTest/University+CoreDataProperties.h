//
//  University+CoreDataProperties.h
//  CoreDataTest
//
//  Created by MacUser on 11.05.16.
//  Copyright © 2016 Shitikov.net. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "University.h"
#import "Course+CoreDataProperties.h"


NS_ASSUME_NONNULL_BEGIN

@interface University (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Course *> *courses;
@property (nullable, nonatomic, retain) NSSet<Student *> *studentd;

@end

@interface University (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(Course *)value;
- (void)removeCoursesObject:(Course *)value;
- (void)addCourses:(NSSet<Course *> *)values;
- (void)removeCourses:(NSSet<Course *> *)values;

- (void)addStudentdObject:(Student *)value;
- (void)removeStudentdObject:(Student *)value;
- (void)addStudentd:(NSSet<Student *> *)values;
- (void)removeStudentd:(NSSet<Student *> *)values;

@end



NS_ASSUME_NONNULL_END
