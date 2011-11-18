//
//  TTSecondViewController.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 03/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "TTViewController.h"

@interface TTCheckinViewController  : UIViewController <TTViewController, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    IBOutlet UILabel *latitudeLabel;
    IBOutlet UILabel *longitudeLabel;


    UIButton *checkinButton;
}

@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) IBOutlet UIButton *checkinButton;

- (IBAction) checkin:(id)sender;

@end
