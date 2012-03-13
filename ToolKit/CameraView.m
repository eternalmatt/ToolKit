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

@interface CameraView ()
@property (strong, nonatomic) NSString *cameraButtonText;
@property (strong, nonatomic) NSString *uploadButtonText;
@property (strong, nonatomic) NSString *alertWindowSuccessTitle;
@property (strong, nonatomic) NSString *alertWindowSuccessBody;

-(void)takePicturePressed:(UIButton*)sender;
-(void)uploadPicturePressed:(UIButton*)sender;
@end

@implementation CameraView
@synthesize locationManager;
@synthesize locationLabel;
@synthesize pickedImage;
@synthesize picker;
@synthesize cameraButtonText, uploadButtonText, alertWindowSuccessTitle, alertWindowSuccessBody;

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) 
    {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.delegate = self;
        
        NSDictionary *bundle         = [[NSBundle mainBundle] infoDictionary];
        self.cameraButtonText        = [bundle objectForKey:@"CameraButtonText"];
        self.uploadButtonText        = [bundle objectForKey:@"UploadButtonText"];
        self.alertWindowSuccessTitle = [bundle objectForKey:@"AlertWindowSuccessTitle"];
        self.alertWindowSuccessBody  = [bundle objectForKey:@"AlertWindowSuccessBody"];
        
        
        const CGRect screen = self.frame;//[[UIScreen mainScreen] bounds];
        
        CGFloat x = screen.origin.x + 10;
        CGFloat width = screen.size.width / 2.0 - 10;
        CGFloat height = 40;
        CGFloat y = screen.size.height + screen.origin.y - (x + height);
        CGRect bounds = CGRectMake(x,y,width,height);
        
        UIButton *takeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        takeButton.frame = bounds;
        [takeButton setTitle:self.cameraButtonText forState:UIControlStateNormal];
        [takeButton addTarget:self action:@selector(takePicturePressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:takeButton];
        
        
        x = x + width + 10;
        y = y;
        width = screen.size.width - (x + 10);
        height = height;
        bounds = CGRectMake(x, y, width, height);
        UIButton *uploadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        uploadButton.frame = bounds;
        uploadButton.titleLabel.numberOfLines = 0;
        [uploadButton setTitle:self.uploadButtonText forState:UIControlStateNormal];
        [uploadButton addTarget:self action:@selector(uploadPicturePressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:uploadButton];
        
        
        
        x = screen.origin.x + 10;
        y = screen.origin.y + 10;
        width = 0;  //will be determined by image's aspect ratio
        height = takeButton.frame.origin.y - y - 10;
        bounds = CGRectMake(x,y,width,height);
        self.pickedImage = [[UIImageView alloc] initWithFrame:bounds];
        [self addSubview:self.pickedImage];
    }
    return self;
}

-(void)takePicturePressed:(UIButton *)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    [self.locationManager startUpdatingLocation]; 
    
    UIViewController *viewcon = [self firstAvailableUIViewController];
    [viewcon presentViewController:picker animated:YES completion:nil];
}

-(void)uploadPicturePressed:(UIButton *)sender
{
    if (self.pickedImage.image)
    {
        [[[UIAlertView alloc] initWithTitle:self.alertWindowSuccessTitle
                                    message:self.alertWindowSuccessBody
                                   delegate:nil 
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Ok", nil] show];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGFloat x = self.pickedImage.frame.origin.x;
    CGFloat y = self.pickedImage.frame.origin.y;
    CGFloat height = self.pickedImage.frame.size.height;
    CGFloat width = height * image.size.width / image.size.height;
    
    self.pickedImage.frame  = CGRectMake(x,y,width,height);
    self.pickedImage.center = CGPointMake(self.center.x, self.pickedImage.center.y);
    self.pickedImage.image  = [image imageScaledToFitSize:CGSizeMake(width, height)];
    
    
    UIViewController *viewcon = [self firstAvailableUIViewController];
    [viewcon dismissModalViewControllerAnimated:YES];
}

-(void)locationManager:(CLLocationManager *)manager 
   didUpdateToLocation:(CLLocation *)newLocation 
          fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];

    CGPoint point = CGPointMake(newLocation.coordinate.longitude, newLocation.coordinate.latitude);
    NSLog(@"%@", NSStringFromCGPoint(point));}



@end
