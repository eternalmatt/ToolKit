//
//  ToolKitViewController.m
//  ToolKit
//
//  Created by Matthew Senn on 2/22/12.
//  Copyright (c) 2012 UNC Charlotte. All rights reserved.
//

#import "ToolKitViewController.h"
#import "AccelerationView.h"
#import "GPSView.h"

@interface ToolKitViewController ()

@end

@implementation ToolKitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"ToolKit";
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height/3.0);
    [self.view addSubview:[[AccelerationView alloc] initWithFrame:bounds]];
    
    
    bounds = CGRectMake(bounds.origin.x, bounds.size.height, bounds.size.width, [UIScreen mainScreen].bounds.size.height - bounds.size.height);
    [self.view addSubview:[[GPSView alloc] initWithFrame:bounds]];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
