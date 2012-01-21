//
//  TTLocationAnnotation.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 20/01/2012.
//  Copyright (c) 2012 Wawra Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface TTLocationAnnotation : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;



@end
