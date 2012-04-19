//
//  CameraView.h
//  ToolKit
//
//  Created by Matthew Senn on 2/22/12.
//  Copyright (c) 2012 UNC Charlotte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol CameraViewDelegate <NSObject>
@required
-(void)imageTaken:(UIImage*)image;
@end


@interface CameraView : UIView
< UIImagePickerControllerDelegate
, CLLocationManagerDelegate
, UINavigationControllerDelegate
>


-(UIImage*)image;

@end
