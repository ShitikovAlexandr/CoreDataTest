//
//  UniversitysViewController.m
//  CoreDataTest
//
//  Created by MacUser on 10.05.16.
//  Copyright © 2016 Shitikov.net. All rights reserved.
//

#import "UniversitysViewController.h"
#import "University.h"
//#import "DataManager.h"

@interface UniversitysViewController ()


@end

@implementation UniversitysViewController
@synthesize fetchedResultsController = _fetchedResultsController;


- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"University" inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    
    NSSortDescriptor *nameDescription = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[nameDescription]];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc]
                                                             initWithFetchRequest:fetchRequest
                                                             managedObjectContext:self.managedObjectContext
                                                             sectionNameKeyPath:nil
                                                             cacheName:@"Master"]; // cash name
    
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }

    
    
    
    
    return _fetchedResultsController;
}    

- (void) configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    University *university = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    cell.textLabel.text = university.name;
    cell.detailTextLabel.text = nil;
    
}

@end
