//
//  AccelerationViewController.m
//  ToolKit
//
//  Created by Matt Senn on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AccelerationViewController.h"

@implementation AccelerationViewController
@synthesize graphView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.title = @"Accelerometer";
        UIAccelerometer *accelerometer = [UIAccelerometer sharedAccelerometer];
        accelerometer.delegate = self;
        accelerometer.updateInterval = 0.25;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.graphView = [[GraphView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width-40, 112)];
    [self.view addSubview:self.graphView];
}

-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    [self.graphView addX:acceleration.x y:acceleration.y z:acceleration.z];
}
 

@end
