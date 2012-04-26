//
//  CameraView.m
//  ToolKit
//
//  Created by Matthew Senn on 2/22/12.
//  Copyright (c) 2012 UNC Charlotte. All rights reserved.
//

#import "CameraView.h"
#import "UIView+UIKitCategories.h"
#import "UIImage+ProportionalFill.h"
#import "NSData+Base64.h"
#import "NSString+Base64.h"
#import "ToolKitXMLBuilder.h"

@interface CameraView ()
@property (strong, nonatomic) NSString *cameraButtonText;
@property (strong, nonatomic) NSString *alertWindowSuccessTitle;
@property (strong, nonatomic) NSString *alertWindowSuccessBody;

@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UIImageView *pickedImage;
@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) CLLocationManager *locationManager;

-(void)takePicturePressed:(UIButton*)sender;
@end

@implementation CameraView
@synthesize locationManager;
@synthesize locationLabel;
@synthesize pickedImage;
@synthesize picker;
@synthesize cameraButtonText, alertWindowSuccessTitle, alertWindowSuccessBody;

-(UIImage*)image
{
    return self.pickedImage.image;
}

- (id)initWithFrame:(const CGRect)frame
{
    if (self = [super initWithFrame:frame]) 
    {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        
        /* reading from bundle for static strings */
        NSDictionary *bundle         = [[NSBundle mainBundle] infoDictionary];
        self.cameraButtonText        = [bundle objectForKey:@"CameraButtonText"];
        self.alertWindowSuccessTitle = [bundle objectForKey:@"AlertWindowSuccessTitle"];
        self.alertWindowSuccessBody  = [bundle objectForKey:@"AlertWindowSuccessBody"];
        
        /* set up bounds for the take picture button */
        CGFloat x = frame.origin.x + 10;
        CGFloat width = frame.size.width / 2.0 - 10;
        CGFloat height = 40;
        CGFloat y = frame.size.height - height - 10;
        CGRect bounds = CGRectMake(x,y,width,height);
        
        /* creating the take picture button */
        UIButton *takeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        takeButton.frame = bounds;
        [takeButton setTitle:self.cameraButtonText forState:UIControlStateNormal];
        [takeButton addTarget:self action:@selector(takePicturePressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:takeButton];        
        
        /* creating the imageView where the image will be displayed */
        x = 10;
        y = 10;
        width = 0;  //will be determined by image's aspect ratio
        height = takeButton.frame.origin.y - 10 - y;
        self.pickedImage = [[UIImageView alloc] initWithFrame:CGRectMake(x,y,width,height)];
        [self addSubview:self.pickedImage];
    }
    return self;
}

-(void)takePicturePressed:(UIButton *)sender
{
    /* try and select the best media for this device */
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    /* record location of picture */
    [self.locationManager startUpdatingLocation]; 
    
    /* present the camera/photo album */
    UIViewController *viewcon = [self firstAvailableUIViewController];
    [viewcon presentModalViewController:picker animated:YES];
    //[viewcon presentViewController:picker animated:YES completion:nil]; //only in iOS 5.0
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    /* adjust imageView so that the frame has good aspect ratio and in center */
    CGRect frame = self.pickedImage.frame;
    frame.size.width = frame.size.height * image.size.width / image.size.height;
    
    self.pickedImage.frame  = frame;
    self.pickedImage.center = CGPointMake(self.center.x, self.pickedImage.center.y);
    
    
    /* imageScaledtoFitSize: method from Matt Gemmell's UIImage category */
    self.pickedImage.image  = [image imageScaledToFitSize:frame.size];

    
    UIViewController *viewcon = [self firstAvailableUIViewController];
    [viewcon dismissModalViewControllerAnimated:YES];
}

-(void)locationManager:(CLLocationManager *)manager 
   didUpdateToLocation:(CLLocation *)newLocation 
          fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];

    CGPoint point = CGPointMake(newLocation.coordinate.longitude, newLocation.coordinate.latitude);
    NSLog(@"%@", NSStringFromCGPoint(point));
}



@end
