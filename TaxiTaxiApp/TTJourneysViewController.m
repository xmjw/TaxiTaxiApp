//
//  TTJourneysViewController.m
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 16/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import "TTJourneysViewController.h"
#import "TTManagedObjectContextProtocol.h"

@implementation TTJourneysViewController 
@synthesize managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void) pushViewController:(UIViewController *) view animated:(BOOL) animated
{
    NSLog(@"Pushing %@",view);
    
    //try and make it do this just once somehow?
    
    id<TTManagedObjectContextProtocol> managedObjectView = (id<TTManagedObjectContextProtocol>) view;
    
    [managedObjectView setManagedObjectContext:managedObjectContext];
    
    [super pushViewController:view animated:animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
