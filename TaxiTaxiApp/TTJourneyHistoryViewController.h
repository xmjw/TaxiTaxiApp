//
//  TTJourneyHistoryViewController.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 21/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTManagedObjectContextProtocol.h"

@interface TTJourneyHistoryViewController : UITableViewController <TTManagedObjectContextProtocol>
{
    NSMutableArray *journeyHistory;
}

#pragma Properties..
@property (nonatomic, retain) NSMutableArray *journeyHistory;

#pragma Methods
- (void) refreshData;

@end
