//
//  TTAppDelegate.m
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 03/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import "TTAppDelegate.h"
#import <objc/runtime.h>

@implementation TTAppDelegate

@synthesize window = _window;

@synthesize managedObjectContext;
@synthesize managedObjectModel;
@synthesize persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory
{
    //core data
    return nil;    
}

- (void)saveContext
{
    //core data
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    

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
        for (UIViewController *viewController in viewControllers)
        {
            // Pass the managed object context to the view controller.
            //viewController.managedObjectContext = context;
            
            NSLog(@"viewControllers %@ has %d children",viewController,[[viewController childViewControllers] count]);
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
