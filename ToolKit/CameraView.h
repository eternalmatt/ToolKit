//
//  CameraView.h
//  ToolKit
//
//  Created by Matthew Senn on 2/22/12.
//  Copyright (c) 2012 UNC Charlotte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CameraView : UIView
< UIImagePickerControllerDelegate
, CLLocationManagerDelegate
, UINavigationControllerDelegate
>

@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UIImageView *pickedImage;
@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end
