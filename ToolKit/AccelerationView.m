//
//  AccelerationViewController.m
//  ToolKit
//
//  Created by Matt Senn on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AccelerationView.h"

enum { ActionButtonRecording = 0, 
    ActionButtonNotRecording = 1};

@interface AccelerationView ()
-(void)actionButtonPressed:(id)sender;
@property (strong, nonatomic) NSString *startButtonText;
@property (strong, nonatomic) NSString *stopButtonText;

@property (strong, nonatomic) GraphView *graphView;
@property (strong, nonatomic) NSMutableArray *accelerationData;
@end

@implementation AccelerationView
@synthesize graphView;
@synthesize accelerationData;
@synthesize data;
@synthesize startButtonText, stopButtonText;

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.accelerationData = [NSMutableArray arrayWithCapacity:1024];
        
        [[UIAccelerometer sharedAccelerometer] setUpdateInterval:0.25];
        
        NSDictionary *bundle    = [[NSBundle mainBundle] infoDictionary];
        self.startButtonText    = [bundle objectForKey:@"ActionButtonStartText"];
        self.stopButtonText     = [bundle objectForKey:@"ActionButtonStopText"];
        
        
        /* graphview to display acceleration data */
        const CGRect screen = self.frame;
        self.graphView = [[GraphView alloc] initWithFrame:CGRectMake(20, 20, screen.size.width-40, 112)];
        [self addSubview:self.graphView];  

        
        
        /* actionButton to start recording and stop recording */
        CGFloat x = screen.origin.x + 10;
        CGFloat width = screen.size.width / 2.0 - 10;
        CGFloat height = 40;
        CGFloat y = self.graphView.frame.origin.y + self.graphView.frame.size.height + 10;
        CGRect bounds = CGRectMake(x,y,width,height);
        
        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        actionButton.frame = bounds;
        actionButton.tag = ActionButtonNotRecording;
        [actionButton setTitle:self.startButtonText forState:UIControlStateNormal];
        [actionButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:actionButton];
        
    }
    return self;
}

-(void)actionButtonPressed:(UIButton*)sender
{
    if (sender.tag == ActionButtonRecording)
    {
        [[UIAccelerometer sharedAccelerometer] setDelegate:nil];
        [sender setTitle:self.startButtonText forState:UIControlStateNormal];
    }
    else
    {
        [[UIAccelerometer sharedAccelerometer] setDelegate:self];
        [sender setTitle:self.stopButtonText forState:UIControlStateNormal];
    }
    
    sender.tag = !sender.tag;
}

-(void)accelerometer:(UIAccelerometer *)accelerometer 
       didAccelerate:(UIAcceleration *)acceleration
{
    //why is the compiler complaining about this line???
    //[self.accelerationData addObject:acceleration];
    [self.graphView addX:acceleration.x y:acceleration.y z:acceleration.z];
}

@end
