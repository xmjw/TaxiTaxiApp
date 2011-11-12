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

//@synthesize managedObjectContext;


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
        return NO;
    }
    
    return YES;
}



@end
