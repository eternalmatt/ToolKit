//
//  IncentivesViewController.m
//  ToolKit
//
//  Created by Matt Senn on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IncentivesViewController.h"

@implementation IncentivesViewController
@synthesize pointsLabel;

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
    
    self.pointsLabel.text = [NSString stringWithFormat:@"%@", response];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
