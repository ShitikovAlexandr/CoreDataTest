//
//  AppDelegate.m
//  CoreDataTest
//
//  Created by MacUser on 26.04.16.
//  Copyright © 2016 Shitikov.net. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"
#import "UniversitysViewController.h"
#import "RootViewController.h"


@interface AppDelegate ()

@property (strong, nonatomic) RootViewController *rootViewController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    self.rootViewController = [[RootViewController alloc] init];
    //self.window.rootViewController = self.rootViewController;
    
    UniversitysViewController *vc = [[UniversitysViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = nav;
            
    return YES;
}

- (void) applicationWillTerminate:(UIApplication *)application {
   [[DataManager sharedManager] saveContext];
}

@end
