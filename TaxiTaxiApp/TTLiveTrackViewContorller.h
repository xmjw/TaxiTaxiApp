//
//  LiveTrackViewContorller.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 03/12/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTManagedObjectContextProtocol.h"
#import <CoreLocation/CoreLocation.h>

@interface TTLiveTrackViewContorller : UIViewController <TTManagedObjectContextProtocol, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;

}
@end
