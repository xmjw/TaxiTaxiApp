//
//  TTViewController.h
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 12/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTViewController : UIViewController
{   
    NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
