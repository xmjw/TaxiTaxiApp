//
//  TTJourneyDetailViewController.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 30/12/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTManagedObjectContextProtocol.h"
#import <MapKit/MapKit.h>
#import "Checkin.h"

@interface TTJourneyDetailViewController : UIViewController <TTManagedObjectContextProtocol, MKMapViewDelegate>
{
    MKMapView* mapView;
    UITextField* price;
    UITextField* plate;
    UILabel *dateDetails;
}

@property (nonatomic, retain) IBOutlet MKMapView* mapView; 
@property (nonatomic, retain) Checkin* checkin;
@property (nonatomic, retain) IBOutlet UITextField* price;
@property (nonatomic, retain) IBOutlet UITextField* plate;
@property (nonatomic, retain) IBOutlet UILabel* dateDetails;

-(void) addLocationsToMap;

@end
