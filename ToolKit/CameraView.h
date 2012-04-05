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


-(UIImage*)image;

@end
