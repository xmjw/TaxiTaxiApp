//
//  TTSecondViewController.m
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 03/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import "TTCheckinViewController.h"
#import "Checkin.h"

@implementation TTCheckinViewController

<<<<<<< HEAD
@synthesize currentLocation;
=======
//@synthesize managedObjectContext;


>>>>>>> checkin-data-model
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Create custom UIButton and overlay it on center of the tab bar.
    [self addCenterButtonWithImage:[UIImage imageNamed:@"cameraTabBarItem.png"] highlightImage:nil];
    
    [latitudeLabel setText:@""];
    [longitudeLabel setText:@""];
    
    // Create location manager object
    if (locationManager == nil)
    {
        locationManager = [[CLLocationManager alloc] init];
    }
    [locationManager setDelegate:self];
    
    // We want all results from the location manager
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    
    // And we want it to be as accurate as possible
    // regardless of how much time/power it takes
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    // Tell our manager to start looking for its location immediately
    [locationManager startUpdatingLocation];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

<<<<<<< HEAD
#pragma mark - Location

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", newLocation);
    
    currentLocation = newLocation;
    
    [locationManager stopUpdatingLocation];
    locationManager = nil;
    
    NSString *lat = [NSString stringWithFormat:@"%1.8f", 
                     newLocation.coordinate.latitude];
    [latitudeLabel setText:lat];
    
    NSString *longt = [NSString stringWithFormat:@"%1.8f", 
                       newLocation.coordinate.longitude];
    [longitudeLabel setText:longt];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
    
    [locationManager stopUpdatingLocation];
    locationManager = nil;
}

#pragma mark - Custom Button

// Create a custom UIButton and add it to the center of our tab bar
-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    
    NSLog(@"Button: %@", button);
    
    CGFloat heightDifference = buttonImage.size.height - self.tabBarController.tabBar.frame.size.height;
    if (heightDifference < 0)
        button.center = self.tabBarController.tabBar.center;
    else
    {
        CGPoint center = self.tabBarController.tabBar.center;
        center.y = center.y - heightDifference/2.0;
        button.center = center;
    }
    
    NSLog(@"self.tabBarController.view: %@", self.tabBarController.view);
    
    [self.tabBarController.view addSubview:button];
}


=======
- (void) dealloc
{
    
}

- (BOOL) createCheckinWithPlate:(NSString*)plateNumber onDate:(NSDate *)when 
{
// Fields from Checkin entity object
//    @dynamic expense;
//    @dynamic gpsAccuracy;
//    @dynamic latitude;
//    @dynamic longitute;
//    @dynamic plate;
//    @dynamic price;
//    @dynamic remoteId;
//    @dynamic synced;
//    @dynamic wasEnd;
//    @dynamic wasStart;
//    @dynamic when;
    
    Checkin *checkin = (Checkin *)[NSEntityDescription insertNewObjectForEntityForName:@"Checkin" inManagedObjectContext:managedObjectContext];
    
    [checkin setPlate:plateNumber];
    [checkin setWhen:when];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) 
    {
        NSLog(@"Failed to create basic checkin object");
        return NO;
    }
    NSLog(@"Created new checkin and commited to managedObjectContext");
    return YES;
}



>>>>>>> checkin-data-model
@end
