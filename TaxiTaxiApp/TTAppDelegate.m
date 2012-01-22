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
#import "TTManagedObjectContextProtocol.h"
#import "Checkin.h"

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
- (NSManagedObjectModel *)managedObjectModel 
{    
    if (managedObjectModel != nil) 
    {
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
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"DataModel.sqlite"]];
    
    NSError *error;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) 
    {
        NSLog(@"ERROR!!! Couldn't create PersistentStoreCoordinator for some reason.");
    }    
    
    return persistentStoreCoordinator;
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
        for (id<TTManagedObjectContextProtocol> viewController in viewControllers)
        {
            // Pass the managed object context to the view controller.
            viewController.managedObjectContext = context;
        }
        
        for (UITabBarItem *item in [[tabBarController tabBar] items])
        {
            NSLog(@"Item %@, and %@, %@",item,[item badgeValue],[item title]);
        }

        UIImage* buttonImage = [UIImage imageNamed:@"Check-In.png"];
        UIImage* highlightImage = [UIImage imageNamed:@"Check-In-Highlighted.png"];
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
        
        CGFloat heightDifference = (buttonImage.size.height - tabBarController.tabBar.frame.size.height) + 25;
        if (heightDifference < 0)
            button.center = tabBarController.tabBar.center;
        else
        {
            CGPoint center = tabBarController.tabBar.center;
            center.y = center.y - heightDifference/2.0;
            button.center = center;
        }
        
        [button addTarget:tabBarController action:@selector(specialButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        
        [tabBarController.view addSubview:button];
        
        
        //Use the below and a button callback to allow it to function...
        tabBarController.selectedIndex = 1;
        
        NSLog(@"Added button to middle...");
    }
    
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
