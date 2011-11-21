//
//  TTJourneySummaryView.m
//  TaxiTaxiApp
//
//  Created by Michael Wawra on 19/11/2011.
//  Copyright (c) 2011 Wawra Corp. All rights reserved.
//

#import "TTJourneySummaryView.h"

@implementation TTJourneySummaryView

@synthesize movementImage;

-(void)initCustom
{
    NSLog(@"init: Setting image to same-up.png");

    if(movementImage != nil)
    {
        NSLog(@"image already displayed:  %@",movementImage.image);
    }
    else NSLog(@"Movement Image is Nil!");
    
    for (UIView * views in [self subviews])
    {
        NSLog(@"Found a %@",views);
    }
    
    movementImage = (UIImageView *)[self viewWithTag: 1];
    
    //test the look of different images...
    int dir =  (arc4random() % 9) + 1;
    
    NSLog(@"%d is chosen",dir);
    
    switch(dir)
    {
        case 0: 
            [movementImage setImage:[UIImage imageNamed:@"up-up.png"]]; 
            break;
        case 1: 
            [movementImage setImage:[UIImage imageNamed:@"up-down.png"]]; 
            break;
        case 2: 
            [movementImage setImage:[UIImage imageNamed:@"up-same.png"]]; 
            break;
        case 3: 
            [movementImage setImage:[UIImage imageNamed:@"same-up.png"]]; 
            break;
        case 4: 
            [movementImage setImage:[UIImage imageNamed:@"same-down.png"]]; 
            break;
        case 5: 
            [movementImage setImage:[UIImage imageNamed:@"same-same.png"]]; 
            break;
        case 6: 
            [movementImage setImage:[UIImage imageNamed:@"down-up.png"]]; 
            break;
        case 7: 
            [movementImage setImage:[UIImage imageNamed:@"down-down.png"]]; 
            break;
        case 8: 
            [movementImage setImage:[UIImage imageNamed:@"down-same.png"]]; 
            break;
        default:
            break;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initCustom];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initCustom];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustom];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
