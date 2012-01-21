//
//  Checkin.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 11/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Checkin : NSManagedObject

@property (nonatomic, retain) NSNumber * expense;
@property (nonatomic, retain) NSNumber * gpsAccuracy;
@property (nonatomic, retain) NSNumber * startLatitude;
@property (nonatomic, retain) NSNumber * startLongitude;
@property (nonatomic, retain) NSNumber * endLatitude;
@property (nonatomic, retain) NSNumber * endLongitude;
@property (nonatomic, retain) NSString * plate;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSNumber * remoteId;
@property (nonatomic, retain) NSNumber * synced;
@property (nonatomic, retain) NSNumber *wasEnd;
@property (nonatomic, retain) NSNumber *wasStart;
@property (nonatomic, retain) NSDate * checkin;
@property (nonatomic, retain) NSDate * checkout;

@end
