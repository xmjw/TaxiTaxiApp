//
//  TTJourneySummaryView.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 19/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTManagedObjectContextProtocol.h"
#import "PageControl.h"

@interface TTJourneySummaryView : UIView <TTManagedObjectContextProtocol, UIScrollViewDelegate, PageControlDelegate>
{
    UIImageView* movementImage;
    UILabel* monthSpend;
    UILabel* weekSpend;
}

@property (nonatomic, retain) IBOutlet UIImageView* movementImage;
@property (nonatomic, retain) IBOutlet UILabel* weekSpend;
@property (nonatomic, retain) IBOutlet UILabel* monthSpend;
@property (nonatomic, retain) IBOutlet UIScrollView* scrollView;
@property (nonatomic, retain) IBOutlet UIView* panningMapView; 
@property (nonatomic, retain) IBOutlet UIView* panningCheckinView; 
@property (nonatomic, retain) IBOutlet UIView* panningCheckoutView; 
@property (nonatomic, retain) IBOutlet PageControl* scrollPaginator;


-(void)initCustom;
-(float) sumSpend: (NSMutableArray *) journeys;

@end
