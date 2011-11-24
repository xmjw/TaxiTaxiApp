//
//  TTViewController.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 12/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTManagedObjectContextProtocol <NSObject>

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
