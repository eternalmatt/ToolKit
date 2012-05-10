//
//  IncentivesViewController.m
//  ToolKit
//
//  Created by Matt Senn on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IncentivesViewController.h"
#import "Incentive.h"

@implementation IncentivesViewController
@synthesize pointsLabel;
@synthesize incentives;
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Incentives";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    /* example of how i'll get the data from the server */
    NSString *request = @"http://www.google.com/?action=points";
    NSURL *url = [NSURL URLWithString:request];
    NSError *error;
    NSString *response = [NSString stringWithContentsOfURL:url 
                                                  encoding:NSASCIIStringEncoding
                                                     error:&error];
    /* stick the response on the label. garbage response until UNCC server is working */
    self.pointsLabel.text = [NSString stringWithFormat:@"%@", response];
    
    
    int points = 0;
    for(Incentive *incentive in self.incentives)
    {
        points += incentive.points.intValue;
    }
    self.pointsLabel.text = [[NSNumber numberWithInt:points] stringValue];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.incentives = [[NSMutableArray alloc] init];
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
