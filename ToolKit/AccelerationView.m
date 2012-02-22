//
//  AccelerationViewController.m
//  ToolKit
//
//  Created by Matt Senn on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AccelerationView.h"

@implementation AccelerationView
@synthesize graphView;

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
        accelerometer.delegate = self;
        accelerometer.updateInterval = 0.25;
        [self loadView];
    }
    return self;
}

- (void)loadView
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.graphView = [[GraphView alloc] initWithFrame:CGRectMake(20, 20, self.frame.size.width-40, 112)];
    [self addSubview:self.graphView];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    [self.graphView addX:acceleration.x y:acceleration.y z:acceleration.z];
}
 

@end
