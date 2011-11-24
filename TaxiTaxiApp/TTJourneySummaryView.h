//
//  TTJourneySummaryView.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 19/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTManagedObjectContextProtocol.h"

@interface TTJourneySummaryView : UIView <TTManagedObjectContextProtocol>
{
    UIImageView* movementImage;
}

@property (nonatomic, retain) IBOutlet UIImageView* movementImage;

-(void)initCustom;

@end
