//
//  GPSViewController.m
//  ToolKit
//
//  Created by Matt Senn on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GPSViewController.h"

typedef enum { 
    GPSStartUpdating = 0, 
    GPSStopUpdating  = 1
} GPSButtonType;

@implementation GPSViewController
@synthesize label, mapView, locationManager;
#pragma mark - Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.title = @"GPS Sensing";
        self.locationManager = [[CLLocationManager alloc] init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    
    UIButton *startButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    startButton.frame = CGRectMake(20, 20, self.view.frame.size.width-40, 40);
    [startButton addTarget:self action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [startButton setTitle:@"Start recording location" forState:UIControlStateNormal];
    [startButton setTag:GPSStartUpdating];
    [self.view addSubview:startButton];
    
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
}

#pragma mark - Button Presses

-(void)showButtonPressed:(UIButton*)sender
{
    UIViewController *viewcon = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    viewcon.title = @"Locations";
    viewcon.view = self.mapView;
    [self.navigationController pushViewController:viewcon animated:YES];
    
    self.mapView.region = MKCoordinateRegionMake(self.mapView.userLocation.coordinate,      //center coordinate
                                                 MKCoordinateSpanMake(0.05, 0.05));         //size in degrees.
}

-(void)startButtonPressed:(UIButton*)sender
{
    if (sender.tag == GPSStartUpdating)
    {
        self.locationManager.delegate = self;		
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
		self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        [self.locationManager startUpdatingLocation];
        
        static BOOL first = YES;
        if (first)
        {
            first = NO;
            
            self.label = [[UILabel alloc] initWithFrame:CGRectMake(20,20,self.view.frame.size.width-40, 40)];
            self.label.textAlignment = UITextAlignmentCenter;
            
            UIButton *showButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];

            [showButton addTarget:self action:@selector(showButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [showButton setTitle:@"Show map" forState:UIControlStateNormal];
            [showButton setTag:GPSStartUpdating];
            
            
            [UIView animateWithDuration:1.0 animations:^{
                
                sender.center = CGPointMake(sender.center.x, sender.center.y + 20 + sender.frame.size.height);
                const CGFloat x = sender.frame.origin.x;
                const CGFloat y = sender.frame.origin.y + sender.frame.size.height + 20;
                const CGFloat w = sender.frame.size.width;
                const CGFloat h = sender.frame.size.height;
                showButton.frame = CGRectMake(x, y, w, h);
                
                [self.view addSubview:showButton];
                [self.view addSubview:self.label];
            }];
        }
    }
    else
    {
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
