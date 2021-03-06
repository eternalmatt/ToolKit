//
//  GPSViewController.h
//  ToolKit
//
//  Created by Matt Senn on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface GPSView : UIView
<MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;


//has the type CLLocation*
-(NSArray*)GPSLocations;

@end
