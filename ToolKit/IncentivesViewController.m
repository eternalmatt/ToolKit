//
//  IncentivesViewController.m
//  ToolKit
//
//  Created by Matt Senn on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IncentivesViewController.h"

@implementation IncentivesViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Incentives";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
