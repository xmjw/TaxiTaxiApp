//
//  TTJourneyDetailViewController.m
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 30/12/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import "TTJourneyDetailViewController.h"
#import "TTLocationAnnotation.h"

@implementation TTJourneyDetailViewController

@synthesize managedObjectContext;
@synthesize mapView;
@synthesize checkin;
@synthesize dateDetails;
@synthesize price;
@synthesize plate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
        //[[MKMapView alloc] initWithFrame:CGRectMake(100, 100, 200, 200) ];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) refreshData
{

    [self addLocationsToMap];
    
    [plate setText:[[self checkin] plate]];    
    [price setText:[NSString stringWithFormat:@"£%@",[[self checkin] price]]];
    
    if ([self.checkin checkin] != nil && [self.checkin checkout] != nil)
    {
        unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;

        NSDateComponents *conversionInfo = [[NSCalendar currentCalendar] components:unitFlags fromDate:[self.checkin checkin] toDate:[self.checkin checkout] options:0];
        
        int years = [conversionInfo year];
        int months = [conversionInfo month];
        int days = [conversionInfo day];
        int hours = [conversionInfo hour];
        int minutes = [conversionInfo minute];

        NSString *dateText = @"";
        
        if (years > 0) dateText = [NSString stringWithFormat:@"%@ %d years, ",dateText,years];
        if (months > 0) dateText = [NSString stringWithFormat:@"%@ %d months, ",dateText,months];
        if (days > 0) dateText = [NSString stringWithFormat:@"%@ %d days, ",dateText,days];
        if (hours > 0) dateText = [NSString stringWithFormat:@"%@ %d hours, ",dateText,hours];
        if (minutes > 0) dateText = [NSString stringWithFormat:@"%@ %d minutes, ",dateText,minutes];
                    
        //Now set the date nicely...
        if ([dateText length]>0) [dateDetails setText:[dateText substringToIndex:[dateText length]-2]];
    }
}

#pragma mark - View lifecycle
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    NSLog(@"[TTJourneyDetailViewController loadView Started]");
    [super loadView];

    [self refreshData];
    
    NSLog(@"[TTJourneyDetailViewController loadView Ended]");
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.


- (void)viewDidLoad
{
    NSLog(@"[TTJourneyDetailViewController viewDidLoad Started]");
    [super viewDidLoad];
    NSLog(@"[TTJourneyDetailViewController viewDidLoad Ended]");
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

- (void)addLocationsToMap
{
    NSMutableArray* annotations=[[NSMutableArray alloc] init];
    
    //If there was as start, we add that pin
    if ([[self checkin] wasStart])
    {
        NSLog(@"Started at Lat/Long %f/%f",[[[self checkin] startLatitude] doubleValue],[[[self checkin] startLongitude] doubleValue]);
        
        CLLocationCoordinate2D startPin;
        startPin.latitude =  [[[self checkin] startLatitude] doubleValue];
        startPin.longitude = [[[self checkin] startLongitude] doubleValue];
        TTLocationAnnotation* startAnnotation=[[TTLocationAnnotation alloc] init];
        startAnnotation.coordinate=startPin;
        [mapView addAnnotation:startAnnotation];
        [annotations addObject:startAnnotation];
    }

    //If there was an end, we add that pin too
    if ([[self checkin] wasEnd] )
    {
        NSLog(@"Ended at Lat/Long %f/%f",[[[self checkin] endLatitude] doubleValue],[[[self checkin] endLongitude] doubleValue]);

        CLLocationCoordinate2D endPin;
        endPin.latitude = [[[self checkin] endLatitude] doubleValue];
        endPin.longitude = [[[self checkin] endLongitude]doubleValue];
        TTLocationAnnotation* endAnnotation=[[TTLocationAnnotation alloc] init];
        endAnnotation.coordinate=endPin;
        [mapView addAnnotation:endAnnotation];
        [annotations addObject:endAnnotation];
    }

    //Check of any pins we created so we can stretch the map accordingly.
    MKMapRect zoomRect = MKMapRectNull;
    for (id <MKAnnotation> annotation in mapView.annotations)
    {
        MKMapPoint annotationPoint = MKMapPointForCoordinate(annotation.coordinate);
        MKMapRect pointRect = MKMapRectMake(annotationPoint.x, annotationPoint.y, 0, 0);
        if (MKMapRectIsNull(zoomRect)) 
        {
            zoomRect = pointRect;
        } 
        else 
        {
            zoomRect = MKMapRectUnion(zoomRect, pointRect);
        }
    }
    [mapView setVisibleMapRect:zoomRect animated:YES];
    
    NSLog(@"%d",[annotations count]);
}

@end
