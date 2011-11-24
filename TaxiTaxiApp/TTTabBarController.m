//
//  TTTabBarController.m
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 23/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import "TTTabBarController.h"

@implementation TTTabBarController

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

-(void) specialButtonPress:(id)sender
{
    self.selectedIndex = 2;
    UIButton* button = (UIButton*)sender;
    [button setHighlighted:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Huh, so viewDidLoad was called on the TTTabBarController has %d sub controlls",[[self viewControllers] count]);
}

- (void) tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSLog(@"tabBar didSelectItem was called...");
    
    //Why does this crash?
    //[super tabBar:tabBar didSelectItem:item];
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
