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

@interface TTCheckinViewController  : UIViewController <TTManagedObjectContextProtocol, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    IBOutlet UILabel *latitudeLabel;
    IBOutlet UILabel *longitudeLabel;
    IBOutlet UITextView *plateNumberTextView;

    UIButton *checkinButton;
}

@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) IBOutlet UIButton *checkinButton;
@property (nonatomic, retain) IBOutlet UITextView *plateNumberTextView;

- (IBAction) checkin:(id)sender;
- (BOOL) createCheckinWithPlate:(NSString*)plateNumber onDate:(NSDate *)when withLongitude:(NSString *)longitude withLatitude:(NSString *)latitude;

@end
