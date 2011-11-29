//
//  TTReceiptsViewController.m
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 03/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import "TTCheckOutViewController.h"

@implementation TTCheckOutViewController

@synthesize currentLocation;
@synthesize managedObjectContext;
@synthesize plateNumber;
@synthesize price;
@synthesize startLatitude;
@synthesize startLongitude;
@synthesize endLatitude;
@synthesize endLongitude;
@synthesize concludesJourney; 
@synthesize scrollView;
@synthesize startCheckinTime;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    Checkin *checkin = [self getLastCheckin];
    
    NSLog(@"Checking if journey was an end state: %@ vs %@",checkin.wasEnd,[NSNumber numberWithBool: NO]);
    //this doesn't seem to work very well?
    if (checkin.wasEnd == 0)
    {
        [startLatitude setText: checkin.startLatitude];
        [startLongitude setText: checkin.startLongitude];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *formattedDateString = [dateFormatter stringFromDate: checkin.checkin];

        [startCheckinTime setText: formattedDateString];

        
        [endLatitude setText:@""];
        [endLongitude setText:@""];
        [plateNumber setText: checkin.plate];
    }
    else 
    {
        [concludesJourney setOn:NO];
        [concludesJourney setEnabled:NO];
        
    }
    
    
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    [endLatitude setText:lat];
    
    NSString *longt = [NSString stringWithFormat:@"%1.8f", 
                       newLocation.coordinate.longitude];
    [endLongitude setText:longt];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
    
    [locationManager stopUpdatingLocation];
    locationManager = nil;
}


#pragma Keyboard Actions

- (IBAction) keyboardDisplayed: (id) sender
{
    
    float x = 0;
    float y = 0;
    
    
    CGSize size = [scrollView contentSize];
    
    x = size.width;
    y = size.height;
    
    NSLog(@"Keyboard is up. Scroll View is x=%f y=%f",x,y);
    [scrollView setContentSize:CGSizeMake(320, 330)];
    
    [scrollView setFrame:CGRectMake(0, 0, 320, 250)];
}

- (IBAction) keyboardHidden: (id) sender
{
    NSLog(@"Keyboard is down again.");
    [scrollView setContentSize:CGSizeMake(320, 330)];
    [scrollView setFrame:CGRectMake(0, 0, 320, 330)];
}

#pragma Checkin actions...

- (IBAction) checkout:(id)sender
{
    NSLog(@"Checkout was called.");
    
    if ([plateNumber isFirstResponder]) [plateNumber resignFirstResponder];
    if ([price isFirstResponder]) [price resignFirstResponder];
    
    NSNumber *priceOfJourney = [NSNumber numberWithFloat:123.43];

    if (concludesJourney.on)
    {
        //conclude the previous journey...
        Checkin *checkin = [self getLastCheckin];
        if ([self createCheckoutFromCheckin:checkin onDate:[NSDate date] withLongitude: endLongitude.text withLatitude:endLatitude.text withPrice: priceOfJourney])
            NSLog(@"Created a Checkin from existing plate with %@",checkin.plate);
        else NSLog(@"Failed to create checkout! Panic.");
    }
    else
    {
        //don't conclude the previous journey, this is a new one.
        if ([self createCheckoutWithPlate: plateNumber.text onDate: [NSDate date] withLongitude:endLongitude.text withLatitude:endLatitude.text withPrice:priceOfJourney])
            NSLog(@"Create a Checking for a new plate with %@",plateNumber.text);
        else NSLog(@"Failed to create checkout! Panic.");
    }
    
}

- (BOOL) createCheckoutWithPlate:(NSString*)plate onDate:(NSDate *)when withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude withPrice:(NSNumber *)priceOfJourney
{
    Checkin *checkin = (Checkin *)[NSEntityDescription insertNewObjectForEntityForName:@"Checkin" inManagedObjectContext:managedObjectContext];
    
    [checkin setPlate:plate];
    [checkin setCheckout: when];
    [checkin setEndLongitude: longitude];
    [checkin setEndLatitude: latitude];
    [checkin setPrice: priceOfJourney];
    [checkin setWasStart: [NSNumber numberWithBool: NO]];
    [checkin setWasEnd: [NSNumber numberWithBool: YES]];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) 
    {
        NSLog(@"Failed to create basic checkin object");
        return NO;
    }
    NSLog(@"Created new checkin and commited to managedObjectContext");
    return YES;}

- (BOOL) createCheckoutFromCheckin:(Checkin*)checkin onDate:(NSDate *)when withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude withPrice:(NSNumber *)priceOfJourney
{
    [checkin setCheckout: when];
    [checkin setEndLongitude: longitude];
    [checkin setEndLatitude: latitude];
    [checkin setPrice: priceOfJourney];
    [checkin setWasEnd: [NSNumber numberWithBool: YES]];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) 
    {
        NSLog(@"Failed to create basic checkin object");
        return NO;
    }
    NSLog(@"Created new checkin and commited to managedObjectContext");
    return YES;
}

//Gets the last checkin, or null, so we can either close that last checkin, or create a new one.
//i.e., the last journey is not the current one, or the user is checking in and out of a taxi.
- (Checkin *) getLastCheckin
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Checkin" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSSortDescriptor *checkinDateSort = [[NSSortDescriptor alloc] initWithKey:@"checkin" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:checkinDateSort, nil];
    [request setSortDescriptors:sortDescriptors];
    [request setFetchLimit:1];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) 
    {
        NSLog(@"Failed to get checkin objects.");
    }
    else NSLog(@"Got %d records from checkin query...",[mutableFetchResults count]);
    
    if (mutableFetchResults != nil && mutableFetchResults.count == 1)
    {
        return [mutableFetchResults objectAtIndex: 0];
    }
    return nil;
}

@end
