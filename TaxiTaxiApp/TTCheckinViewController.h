//
//  TTSecondViewController.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 03/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TTCheckinViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    IBOutlet UILabel *latitudeLabel;
    IBOutlet UILabel *longitudeLabel;
}

@property (nonatomic, retain) CLLocation *currentLocation;

-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage;

@end
