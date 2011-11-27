//
//  TTReceiptsViewController.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 03/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTManagedObjectContextProtocol.h"
#import "Checkin.h"
#import <CoreLocation/CoreLocation.h>

@interface TTCheckOutViewController : UIViewController <CLLocationManagerDelegate, TTManagedObjectContextProtocol>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    IBOutlet UITextField* plateNumber;
    IBOutlet UITextField* price;
    IBOutlet UILabel* startLatitude;
    IBOutlet UILabel* startLongitude;
    IBOutlet UILabel* endLatitude;
    IBOutlet UILabel* endLongitude;
    IBOutlet UISwitch* concludesJourney; 
    IBOutlet UIScrollView* scrollView;
    IBOutlet UILabel* startCheckinTime;
}

@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) IBOutlet UITextField* plateNumber;
@property (nonatomic, retain) IBOutlet UITextField* price;
@property (nonatomic, retain) IBOutlet UILabel* startLatitude;
@property (nonatomic, retain) IBOutlet UILabel* startLongitude;
@property (nonatomic, retain) IBOutlet UILabel* endLatitude;
@property (nonatomic, retain) IBOutlet UILabel* endLongitude;
@property (nonatomic, retain) IBOutlet UISwitch* concludesJourney; 
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UILabel* startCheckinTime;

- (IBAction) keyboardDisplayed: (id) sender;
- (IBAction) keyboardHidden: (id) sender;

- (BOOL) createCheckoutFromCheckin:(Checkin*)checkin onDate:(NSDate *)when withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude withPrice:(NSNumber *)price;
- (BOOL) createCheckoutWithPlate:(NSString*)plateNumber onDate:(NSDate *)when withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude withPrice:(NSNumber *)price;
- (Checkin *) getLastCheckin;

@end
