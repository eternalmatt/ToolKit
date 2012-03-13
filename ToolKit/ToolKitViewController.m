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
#import "CameraView.h"

@interface ToolKitViewController ()
@end

@implementation ToolKitViewController

- (void)loadView
{
    [super loadView];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    
    
    bounds = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, 192);
    [scrollView addSubview:[[CameraView alloc] initWithFrame:bounds]];
    
    
    bounds = CGRectMake(bounds.origin.x, bounds.size.height, bounds.size.width, 250);
    [scrollView addSubview:[[GPSView alloc] initWithFrame:bounds]];
    
    CGSize contentSize = CGSizeMake(scrollView.frame.size.width, 0);
    for (UIView *view in scrollView.subviews)
    {
        contentSize.height += view.frame.size.height;
    }
    
    scrollView.contentSize = contentSize;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

@end
