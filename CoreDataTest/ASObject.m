//
//  ASObject.m
//  CoreDataTest
//
//  Created by MacUser on 06.05.16.
//  Copyright © 2016 Shitikov.net. All rights reserved.
//

#import "ASObject.h"

@implementation ASObject

// Insert code here to add functionality to your managed object subclass

- (BOOL) validateForDelete:(NSError * _Nullable __autoreleasing *)error {
    
    NSLog(@">>>>  validateForDelete %@", NSStringFromClass([self class]));
    
    return YES;
}

@end
