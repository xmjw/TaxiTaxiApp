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
#import <MapKit/MapKit.h>

@interface TTCheckOutViewController : UIViewController <CLLocationManagerDelegate, TTManagedObjectContextProtocol, UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) IBOutlet UITextField* plateNumber;
@property (nonatomic, retain) IBOutlet UITextField* price;
@property (nonatomic, retain) IBOutlet UISwitch* concludesJourney; 
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UILabel* startCheckinTime;

- (IBAction) keyboardDisplayed: (id) sender;
- (IBAction) keyboardHidden: (id) sender;

- (BOOL) createCheckoutWithPlate:(NSString*)plate onDate:(NSDate *)when withLongitude:(NSNumber *)longitude withLatitude:(NSNumber *)latitude withPrice:(NSNumber *)priceOfJourney;
- (BOOL) createCheckoutFromCheckin:(Checkin*)checkin onDate:(NSDate *)when withLongitude:(NSNumber *)longitude withLatitude:(NSNumber *)latitude withPrice:(NSNumber *)priceOfJourney;
- (Checkin *) getLastCheckin;
- (IBAction) checkout:(id)sender;

@end
