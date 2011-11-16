//
//  TTAppDelegate.m
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 03/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import "TTAppDelegate.h"
#import <CoreData/CoreData.h>
#import <objc/runtime.h>
#import "TTViewController.h"

@implementation TTAppDelegate

@synthesize window = _window;

@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;



- (NSString *)applicationDocumentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

- (void)saveContext
{
    //core data
    
}


/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
    
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];    
    return managedObjectModel;
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"TaxiTaxiApp.sqlite"]];
    
    
    NSError *error;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        // Handle the error.
    }    
    
    return persistentStoreCoordinator;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if (managedObjectContext == nil) 
    {
        NSLog(@"Trying to create a managedObjectContext");
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator != nil) 
        {
            
            managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType: NSMainQueueConcurrencyType];
            NSLog(@"Created managedobjectContext %@",managedObjectContext);
            //[managedObjectContext setPersistentStoreCoordinator: coordinator];
        }
        else NSLog(@"No NSPersistentStoreCoordinator, cannot create a managedObjectContext");
    }    
    
    //[mjw] this need to go somewhere else, not sure to access the controllers with so much generated code.
    //Handle the core data model, and pass it to each tab. somehow.
    NSManagedObjectContext *context = [self managedObjectContext];
    if (!context) 
    {
        NSLog(@"Fatally failed to get the managed object context for the application. Cannot continue.");
        //todo: Panic and crash cleanly?
    }
    else
    {
        //Get hold of the tab bar controller
        UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
        //Get the array of the individual views.
        NSArray *viewControllers = (NSArray *)[tabBarController viewControllers];

        //Loop through the view controllers, and make sure they've all got a reference to the NSManagedObjectContext.
        for (TTViewController *viewController in viewControllers)
        {
            NSLog(@"Assigning Managed object context to %@",viewController);
            // Pass the managed object context to the view controller.
            viewController.managedObjectContext = context;
            NSLog(@"Assigning managed object context to TTViewController");
        }
    }
    // Configure myViewController.
    
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
