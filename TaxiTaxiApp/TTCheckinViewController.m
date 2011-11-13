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

@synthesize currentLocation;
@synthesize checkinButton;

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


#pragma mark Location

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


- (void) dealloc
{
    
}

- (IBAction) checkin:(id)sender
{
    NSLog(@"Checkin was called...");
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

@end
