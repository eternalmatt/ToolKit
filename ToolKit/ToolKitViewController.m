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
@property (nonatomic, strong) UIScrollView *scrollView;
-(void)uploadButtonPressed:(UIButton*)sender;
@end

@implementation ToolKitViewController
@synthesize scrollView;

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    /* setting up uploadButton */
    UIButton *uploadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    uploadButton.frame = CGRectMake(bounds.origin.x+20, bounds.origin.y+10, bounds.size.width-40, 40);
    
    [uploadButton setTitle:@"Upload to Campaign" 
                  forState:UIControlStateNormal];
    
    [uploadButton addTarget:self 
                     action:@selector(uploadButtonPressed:)
           forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:uploadButton];
    
    
    /* creating scrollView */
    bounds.origin.y    += uploadButton.frame.origin.y + uploadButton.frame.size.height + 10;
    bounds.size.height -= bounds.origin.y;
    self.scrollView = [[UIScrollView alloc] initWithFrame:bounds];
    
    
    
    /* sizes for all views in scrollView*/
    bounds.origin.y = 0;
    bounds.size.height = 250;
    CGSize smallSize    = CGSizeMake(bounds.size.width, 190);
    CGSize standardSize = CGSizeMake(bounds.size.width, 250);

    /* looping through bundle for views and adding to scrollView */
    NSDictionary *bundle = [[NSBundle mainBundle] infoDictionary];
    for(NSString *string in [bundle objectForKey:@"Sensors"])
    {
        NSLog(@"%@", string);
        UIView *view = nil;
        if      ([string isEqualToString:@"Acceleration"])
            view = [[AccelerationView alloc] initWithFrame:bounds];
        else if ([string isEqualToString:@"Camera"])
        {
            bounds.size = smallSize;
            view = [[CameraView alloc] initWithFrame:bounds];
        }
        else if ([string isEqualToString:@"Location"])
            view = [[GPSView alloc] initWithFrame:bounds];
        else if ([string isEqualToString:@"TextInput"])
            view = [[TextInputView alloc] initWithFrame:bounds];
        
        
        
        if (view) 
        {
            view.backgroundColor = self.view.backgroundColor;
            [self.scrollView addSubview:view];
            bounds.origin.y += view.frame.size.height;
            bounds.size      = standardSize;
        }
    }
    
    /* determining size of ths scrollview and adding it to self.view */
    CGSize contentSize = CGSizeMake(self.scrollView.frame.size.width, 0);
    for (UIView *view in self.scrollView.subviews)
    {
        contentSize.height += view.frame.size.height;
    }
    
    scrollView.contentSize = contentSize;
    [self.view addSubview:self.scrollView];
}

-(void)uploadButtonPressed:(UIButton*)sender
{
    ToolKitXMLBuilder *builder = [[ToolKitXMLBuilder alloc] init];
    for(UIView *view in self.scrollView.subviews)
    {
        if ([view isKindOfClass:[CameraView class]])
        {
            CameraView *v = (CameraView*)view;
            [builder addCamera:v.image];
        }
        else if ([view isKindOfClass:[AccelerationView class]])
        {
            AccelerationView *v = (AccelerationView*)view;
            [builder addAcceleration:v.data];
        }
        else if ([view isKindOfClass:[GPSView class]])
        {
            GPSView *v = (GPSView*)view;
            [builder addGPS:v.GPSLocations];
        }
        else if ([view isKindOfClass:[TextInputView class]])
        {
            TextInputView *v = (TextInputView*)view;
            [builder addTextInput:v.textStringsFromUser];
        }
        NSLog(@"%@", builder.generateXML);
    }
    
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

@end
