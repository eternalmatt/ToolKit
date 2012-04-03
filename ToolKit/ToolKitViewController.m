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
#import "TextInputView.h"
#import "ToolKitXMLBuilder.h"

@interface ToolKitViewController ()
@end

@implementation ToolKitViewController

-(void)loadView
{
    [super loadView];
    ToolKitXMLBuilder *builder = [[ToolKitXMLBuilder alloc] init];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    
    CGFloat y = bounds.origin.y;
    bounds = CGRectMake(bounds.origin.x, y, bounds.size.width, 192);
    [scrollView addSubview:[[CameraView alloc] initWithFrame:bounds]];
    y += bounds.size.height;
    
    bounds = CGRectMake(bounds.origin.x, y, bounds.size.width, 192);
    [scrollView addSubview:[[AccelerationView alloc] initWithFrame:bounds]];
    y += bounds.size.height;
    
    bounds = CGRectMake(bounds.origin.x, y, bounds.size.width, 250);
    [scrollView addSubview:[[GPSView alloc] initWithFrame:bounds]];
    y += bounds.size.height;
    
    bounds = CGRectMake(bounds.origin.x, y, bounds.size.width, 250);
    [scrollView addSubview:[[TextInputView alloc] initWithFrame:bounds]];
    y += bounds.size.height;
    
    
    CGSize contentSize = CGSizeMake(scrollView.frame.size.width, 0);
    for (UIView *view in scrollView.subviews)
    {
        contentSize.height += view.frame.size.height;
    }
    
    scrollView.contentSize = contentSize;
    [self.view addSubview:scrollView];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

@end
