//
//  TTSecondViewController.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 03/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TTManagedObjectContextProtocol.h"
#import <MapKit/MapKit.h>

@interface TTCheckinViewController  : UIViewController <TTManagedObjectContextProtocol, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;

    IBOutlet UITextField *plateNumberTextView;
    
    UIButton *checkinButton;
    
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) IBOutlet UIButton *checkinButton;
@property (nonatomic, retain) IBOutlet UITextField *plateNumberTextView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;

- (IBAction) keyboardDisplayed:(NSNotification *)inNotification;
- (IBAction) keyboardHidden:(NSNotification *)inNotification;
- (IBAction) checkin:(id)sender;
- (BOOL) createCheckinWithPlate:(NSString*)plateNumber onDate:(NSDate *)when withLongitude:(NSNumber *)longitude withLatitude:(NSNumber *)latitude;

@end
