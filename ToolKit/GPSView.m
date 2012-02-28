//
//  GPSViewController.m
//  ToolKit
//
//  Created by Matt Senn on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GPSView.h"
#import "UIView+UIKitCategories.h"

typedef enum { 
    GPSStartUpdating = 0, 
    GPSStopUpdating  = 1
} GPSButtonType;

@interface GPSView ()
@property (strong, nonatomic) NSString *uploadButtonText;
@property (strong, nonatomic) NSString *actionButtonStartText;
@property (strong, nonatomic) NSString *actionButtonStopText;
@property (strong, nonatomic) NSString *showMapButtonText;
@end

@implementation GPSView
@synthesize label, mapView, locationManager;
@synthesize uploadButtonText, actionButtonStartText, actionButtonStopText, showMapButtonText;

#pragma mark - Initialization
-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        NSDictionary *bundle = [[NSBundle mainBundle] infoDictionary];
        self.uploadButtonText = [bundle objectForKey:@"UploadButtonText"];
        self.actionButtonStartText = [bundle objectForKey:@"ActionButtonStartText"];
        self.actionButtonStopText = [bundle objectForKey:@"ActionButtonStopText"];
        self.showMapButtonText = [bundle objectForKey:@"ShowMapButtonText"];
        
        self.locationManager = [[CLLocationManager alloc] init];        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        startButton.frame = CGRectMake(20, 20, self.frame.size.width-40, 40);
        [startButton addTarget:self action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [startButton setTitle:self.actionButtonStartText forState:UIControlStateNormal];
        [startButton setTag:GPSStartUpdating];
        [self addSubview:startButton];
        
        
        self.mapView = [[MKMapView alloc] initWithFrame:self.frame];
        self.mapView.showsUserLocation = YES;
        self.mapView.delegate = self;
    }
    return self;
}

#pragma mark - Button Presses

-(void)showButtonPressed:(UIButton*)sender
{
    UIViewController *viewcon = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    viewcon.title = @"Locations";
    viewcon.view = self.mapView;
    
    UIViewController *parent = [self firstAvailableUIViewController];
    [parent.navigationController pushViewController:viewcon animated:YES];
    
    self.mapView.region = MKCoordinateRegionMake(self.mapView.userLocation.coordinate,      //center coordinate
                                                 MKCoordinateSpanMake(0.05, 0.05));         //size in degrees.
}

-(void)startButtonPressed:(UIButton*)sender
{
    if (sender.tag == GPSStartUpdating)
    {
        [sender setTitle:self.actionButtonStopText forState:UIControlStateNormal];
        self.locationManager.delegate = self;		
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        [self.locationManager startUpdatingLocation];
        
        static BOOL first = YES;
        if (first)
        {
            first = NO;
            
            self.label = [[UILabel alloc] initWithFrame:CGRectMake(20,20,self.frame.size.width-40, 40)];
            self.label.textAlignment = UITextAlignmentCenter;
            self.label.backgroundColor = [UIColor clearColor];
            
            UIButton *showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

            [showButton addTarget:self action:@selector(showButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [showButton setTitle:self.showMapButtonText forState:UIControlStateNormal];
            [showButton setTag:GPSStartUpdating];
            
            
            [UIView animateWithDuration:1.0 animations:^{
                
                sender.center = CGPointMake(sender.center.x, sender.center.y + 20 + sender.frame.size.height);
                const CGFloat x = sender.frame.origin.x;
                const CGFloat y = sender.frame.origin.y + sender.frame.size.height + 20;
                const CGFloat w = sender.frame.size.width;
                const CGFloat h = sender.frame.size.height;
                showButton.frame = CGRectMake(x, y, w, h);
                
                [self addSubview:showButton];
                [self addSubview:self.label];
            }];
        }
    }
    else
    {
        [sender setTitle:self.actionButtonStartText forState:UIControlStateNormal];
        [self.locationManager stopUpdatingLocation];
        self.locationManager.delegate = nil;
    }
    
    sender.tag = !sender.tag;
}

#pragma mark - Delegate methdos

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    if (newLocation.timestamp.timeIntervalSinceNow < 5.0)
    {
        self.label.text = [NSString stringWithFormat:@"GPS: %.5f %.5f\"", newLocation.coordinate.longitude, newLocation.coordinate.latitude];
        
        CLLocationCoordinate2D coordinate = [newLocation coordinate];
        [self.mapView addOverlay:[MKPolyline polylineWithCoordinates:&coordinate count:1]];
    }
}

-(MKOverlayView*)mapView:(MKMapView *)mapView viewForOverlay:(MKPolyline*)overlay //could be any overlay of type id<MKOverlay>
{
    MKPolylineView *view = [[MKPolylineView alloc] initWithPolyline:overlay];
    view.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
    view.lineWidth = 5;
    return view;
}


@end
