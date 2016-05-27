//
//  DataManager.m
//  CoreDataTest
//
//  Created by MacUser on 09.05.16.
//  Copyright © 2016 Shitikov.net. All rights reserved.
//

#import "DataManager.h"
#import "Student.h"
#import "Car.h"
#import "ASObject.h"
#import "University.h"
#import "Course.h"

static NSString *randomFirstNames[] = {@"Alex", @"Victor", @"Bob", @"Johan", @"Kelli"};
static NSString *randomLastNames[] = {@"Shitikov", @"Petrenko", @"Studilko", @"Bezbalko", @"Tchapaluk"};
static NSString *randomCarsModels[] = {@"Chevrolet", @"BMW", @"Mercedes", @"Dodge", @"Toyota"};


@implementation DataManager

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

+ (DataManager*) sharedManager {
    
    static DataManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^ {
        manager = [[DataManager alloc] init];
    });
    
    return manager;
}



- (void) generateAndAddUniversity {
    
    //[self deleteAllObjects];
    
    NSError* error = nil;
    
    NSArray *courses = @[[self addCourseWhithName:@"IOS"],
                         [self addCourseWhithName:@"Android"],
                         [self addCourseWhithName:@"PHP"],
                         [self addCourseWhithName:@"JavaScript"],
                         [self addCourseWhithName:@"HTML"]];
    
    University *university = [self addUniversity];
    [university addCourses:[NSSet setWithArray:courses]];
    
    
    for (int i = 0; i < 100; i++) {
        
        Student *student = [self addRandomStudent];
        
        if (arc4random_uniform(1000) < 500) {
            Car *car1 = [self addRandomCar];
            student.car = car1;
        }
        student.university = university;
        
        NSInteger number = arc4random_uniform(5) + 1;
        
        while ([student.courses count] < number ) {
            Course *course = [courses objectAtIndex:arc4random_uniform(5)];
            
            if (![student.courses containsObject:course]) {
                [student addCoursesObject:course];
            }
        }
    }
    
    
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"sdsdssd %@", [error localizedDescription]);
    }
}

- (Student*) addRandomStudent {
    
    Student* student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    
    student.score = @((float)arc4random_uniform(200) / 100.f +2.f);
    student.dateOfBirth = [NSDate dateWithTimeIntervalSince1970:60*60*25*365*arc4random_uniform(31)];
    
    
    
    student.firstName = randomFirstNames[arc4random_uniform(5)];
    student.lastName = randomLastNames[arc4random_uniform(5)];
    
    return student;
}

- (Car*) addRandomCar {
    
    Car* car = [NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:self.managedObjectContext];
    
    car.model = randomCarsModels [arc4random_uniform(5)];
    
    return car;
}

- (University*) addUniversity {
    
    University* university = [NSEntityDescription insertNewObjectForEntityForName:@"University" inManagedObjectContext:self.managedObjectContext];
    
    university.name = @"VNTU";
    
    return university;
}

- (Course*) addCourseWhithName: (NSString*) name {
    
    Course* course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.managedObjectContext];
    
    course.name = name;
    
    return course;
}

- (NSArray*) allObjects {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"ASObject" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    
    if (requestError) {
        NSLog(@"requestError %@", [requestError localizedDescription]);
    }
    
    return resultArray;
}

- (void) printArray: (NSArray*) array {
    
    for (id object in array) {
        
        if ([object isKindOfClass:[Car class]]) {
            
            Car* car = (Car*) object;
            NSLog(@"CAR: %@ OWNER: %@ %@", car.model, car.owner.firstName, car.owner.lastName);
            
        } else if ([object isKindOfClass:[Student class]]) {
            
            Student *student = (Student*) object;
            NSLog(@"STUDENT: %@ %@   SCORE %1.2f Courses: %d", student.firstName, student.lastName,  [student.score floatValue], [student.courses count]);
            
            
        } else if ([object isKindOfClass:[University class]]) {
            
            University *university = (University*) object;
            NSLog(@"University: %@   count of students: %d ",university.name, [university.studentd count]);
            
        } else if ([object isKindOfClass:[Course class]]) {
            
            Course *course = (Course*) object;
            NSLog(@"Course: %@ students: %d", course.name, [course.students count]);
            
        }
    }
    
    NSLog(@"COUNT: %d", [array count]);
}

- (void) printAllObjects {
    
    NSArray* allObjects = [self allObjects];
    
    [self printArray:allObjects];
}

- (void) deleteAllObjects {
    NSArray* allObjects = [self allObjects];
    
    for (id object in allObjects) {
        [self.managedObjectContext deleteObject:object];
    }
    
    [self.managedObjectContext save:nil];
    
}


#pragma mark - Core Data stack



- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "Shitikov.CoreDataTest" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataTest" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataTest.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        //*********
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]; //если не вышло соеденить сущность и бд добовляем эти строки.
        [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        //***********
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
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
