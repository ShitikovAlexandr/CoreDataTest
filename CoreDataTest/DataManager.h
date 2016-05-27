//
//  DataManager.h
//  CoreDataTest
//
//  Created by MacUser on 09.05.16.
//  Copyright © 2016 Shitikov.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


+ (DataManager*) sharedManager;

- (void) generateAndAddUniversity;

@end
