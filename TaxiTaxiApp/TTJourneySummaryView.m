//
//  TTJourneySummaryView.m
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 19/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import "TTJourneySummaryView.h"
#import "Checkin.h"

@implementation TTJourneySummaryView

@synthesize managedObjectContext;
@synthesize movementImage;
@synthesize weekSpend;
@synthesize monthSpend;

-(void)initCustom
{
    NSLog(@"init: Setting image to same-up.png");

    if(movementImage != nil)
    {
        NSLog(@"image already displayed:  %@",movementImage.image);
    }
    else NSLog(@"Movement Image is Nil!");
    
    for (UIView * views in [self subviews])
    {
        NSLog(@"Found a %@",views);
    }
}


-(float) sumSpend: (NSMutableArray *) journeys
{
    float total=0;
    
    for (Checkin *c in journeys)
    {
        total += [[c price] floatValue];
    }
    
    return total;
}

- (NSString *) monthChangeData
{
     
    int thisMonthCount=0;
    int lastMonthCount=0;
    
    //get the last month, current month, last week, and current week to see what the change is.
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Checkin" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];    
    
    NSDate *now = [NSDate date];
	NSDateComponents *dc = [[NSDateComponents alloc] init];
	[dc setMonth:-1];
	NSDate *oneMonthAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:now options:0];
    
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"checkin > %@ or checkout > %@ ",oneMonthAgo,oneMonthAgo];
    
    [request setPredicate:datePredicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) 
    {
        NSLog(@"Failed to get checkin objects.");
    }
    else 
    {
        thisMonthCount = [mutableFetchResults count];
        NSLog(@"Last month has %d records",[mutableFetchResults count]);
        [monthSpend setText: [NSString stringWithFormat:@"£%1.2f", [self sumSpend:mutableFetchResults]]];
    }
    
    request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];    
    
    dc = [[NSDateComponents alloc] init];
	[dc setMonth:-2];
	NSDate *twoMonthsAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:now options:0];
    
    datePredicate = [NSPredicate predicateWithFormat:@"(checkin > %@ or checkout > %@) and (checkin < %@ or checkout < %@) ",twoMonthsAgo,twoMonthsAgo,oneMonthAgo,oneMonthAgo];
    
    [request setPredicate:datePredicate];
    
    error = nil;
    mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) 
    {
        NSLog(@"Failed to get checkin objects.");
    }
    else 
    {
        lastMonthCount = [mutableFetchResults count];
        NSLog(@"Previous month has %d records.",[mutableFetchResults count]);
    }
    
    //Work out which of the 3 week components to display.
    if (lastMonthCount > thisMonthCount) 
    {
        return @"down";
    }
    else if (lastMonthCount < thisMonthCount)
    {
        return @"up";
    }
    else 
    {
        return @"same";
    }

    

}

- (NSString *) weekChangeData
{
    int thisWeekCount=0;
    int lastWeekCount=0;
    
    //get the last month, current month, last week, and current week to see what the change is.
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Checkin" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];    
    
    NSDate *now = [NSDate date];
	NSDateComponents *dc = [[NSDateComponents alloc] init];
	[dc setDay:-7];
	NSDate *oneWeekAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:now options:0];
  
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"checkin > %@ or checkout > %@ ",oneWeekAgo,oneWeekAgo];
    
    [request setPredicate:datePredicate];
        
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) 
    {
        NSLog(@"Failed to get checkin objects.");
    }
    else 
    {
        thisWeekCount = [mutableFetchResults count];
        NSLog(@"Last week has %d checkins",[mutableFetchResults count]);
        [weekSpend setText: [NSString stringWithFormat:@"£%1.2f", [self sumSpend:mutableFetchResults]]];

    }
    
    

    request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];    
    
    dc = [[NSDateComponents alloc] init];
	[dc setDay:-14];
	NSDate *twoWeeksAgo = [[NSCalendar currentCalendar] dateByAddingComponents:dc toDate:now options:0];
    
    datePredicate = [NSPredicate predicateWithFormat:@"(checkin > %@ OR checkout > %@) AND (checkin < %@ OR checkout < %@)",twoWeeksAgo,twoWeeksAgo,oneWeekAgo,oneWeekAgo];
    
    [request setPredicate:datePredicate];
    
    error = nil;
    mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) 
    {
        NSLog(@"Failed to get checkin objects.");
    }
    else 
    {
        lastWeekCount = [mutableFetchResults count];
        NSLog(@"Previous week has %d checkins",[mutableFetchResults count]);
    }
    
    //Work out which of the 3 week components to display.
    if (lastWeekCount > thisWeekCount) 
    {
        return @"-down.png";
    }
    else if (lastWeekCount < thisWeekCount)
    {
        return @"-up.png";
    }
    else 
    {
        return @"-same.png";
    }
    
    //[self setJourneyHistory: mutableFetchResults];
}

- (void) didMoveToWindow
{
    NSLog(@"At this point, TTJourneySummaryView would like to have a manageObjectContext.");

    //find out what has been happening lateley and display the correct icons (this is going to be a basted to test...)
    movementImage = (UIImageView *)[self viewWithTag: 1];
    NSString *directionImage = [NSString stringWithFormat:@"%@%@",[self monthChangeData],[self weekChangeData]];
    [movementImage setImage:[UIImage imageNamed:directionImage]]; 
    
    [self initCustom];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initCustom];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initCustom];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustom];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
