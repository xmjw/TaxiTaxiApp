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
@synthesize managedObjectContext;
@synthesize plateNumberTextView;
@synthesize scrollView;
@synthesize mapView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - MapKit View

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"[TTCheckinViewController viewDidLoad]");

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
    
    mapView.showsUserLocation=YES;
    mapView.userTrackingMode = MKUserTrackingModeFollow;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    mapView.userTrackingMode = MKUserTrackingModeNone;

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

    //setup location on the map.
    MKCoordinateRegion region;

    CLLocationDistance latitudinalMeters = 750;
    CLLocationDistance longitudinalMeters = 1500;
    
    
    region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, latitudinalMeters, longitudinalMeters);
    
    NSLog(@"Location : Latitude %f Longitude %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
    
    //region.span=span;
    [mapView setRegion:region animated:TRUE];

    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
    
    [locationManager stopUpdatingLocation];
    locationManager = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"TTCheckinViewController textFieldShouldReturn");
    [textField resignFirstResponder];
    return YES;
}

- (void) dealloc
{
    
}


- (IBAction) keyboardDisplayed:(NSNotification *)inNotification
{
    
    float x = 0;
    float y = 0;
    
    
    CGSize size = [scrollView contentSize];
    
    x = size.width;
    y = size.height;
    
    NSLog(@"Keyboard is up. Scroll View is x=%f y=%f",x,y);
    [scrollView setContentSize:CGSizeMake(320, 400)];
    
    [scrollView setFrame:CGRectMake(0, 0, 320, 300)];

    
    
}

- (IBAction) keyboardHidden:(NSNotification *)inNotification
{
    NSLog(@"Keyboard is down again.");
}


- (IBAction) checkin:(id)sender
{
    if ([self createCheckinWithPlate:[plateNumberTextView text] onDate:[NSDate date] withLongitude:[NSNumber numberWithDouble:mapView.region.center.longitude] withLatitude:[NSNumber numberWithDouble:mapView.region.center.latitude]])
    {
        NSLog(@"Wrote a checkin to the database");
    }
    else NSLog(@"Failed to write the checkin");
    
    [plateNumberTextView resignFirstResponder];
}

- (BOOL) createCheckinWithPlate:(NSString*)plateNumber onDate:(NSDate *)when withLongitude:(NSNumber *)longitude withLatitude:(NSNumber *)latitude
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
    [checkin setCheckin: when];
    [checkin setStartLongitude: longitude];
    [checkin setStartLatitude: latitude];
    [checkin setWasStart: [NSNumber numberWithBool: YES]];
    [checkin setWasEnd: [NSNumber numberWithBool:NO]];
    
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
