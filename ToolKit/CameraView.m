//
//  CameraView.m
//  ToolKit
//
//  Created by Matthew Senn on 2/22/12.
//  Copyright (c) 2012 UNC Charlotte. All rights reserved.
//

#import "CameraView.h"
#import "UIView+UIKitCategories.h"

@interface CameraView ()

-(void)buttonPressed:(UIButton*)sender;

@end

@implementation CameraView
@synthesize locationManager;
@synthesize locationLabel;
@synthesize pickedImage;
@synthesize picker;

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
        
        const CGRect screen = self.frame;//[[UIScreen mainScreen] bounds];
        
        CGFloat x = screen.origin.x + 10;
        CGFloat width = screen.size.width / 2.0 - 10;
        CGFloat height = 40;
        CGFloat y = screen.size.height + screen.origin.y - (x + height);
        CGRect bounds = CGRectMake(x,y,width,height);
        
        UIButton *takeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        takeButton.frame = bounds;
        [takeButton setTitle:@"Take a pic!" forState:UIControlStateNormal];
        [takeButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:takeButton];
        
        
        x = x + width + 10;
        y = y;
        width = screen.size.width - (x + 10);
        height = height;
        bounds = CGRectMake(x, y, width, height);
        UIButton *uploadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        uploadButton.frame = bounds;
        [uploadButton setTitle:@"Upload" forState:UIControlStateNormal];
        [uploadButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:uploadButton];
        
        
        
        x = screen.origin.x + 10;
        y = screen.origin.y + 10;
        width = screen.size.width - ( 2 * 10 );
        height = takeButton.frame.origin.y - y - 10;
        bounds = CGRectMake(x,y,width,height);
        self.pickedImage = [[UIImageView alloc] initWithFrame:bounds];
        [self addSubview:self.pickedImage];
    }
    return self;
}

-(void)buttonPressed:(UIButton *)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
        self.picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    //[self.locationManager startUpdatingLocation]; 
    
    UIViewController *viewcon = [self firstAvailableUIViewController];
    [viewcon presentViewController:picker animated:YES completion:nil];
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    CGFloat x = self.pickedImage.frame.origin.x;
    CGFloat y = self.pickedImage.frame.origin.y;
    CGFloat height = self.pickedImage.frame.size.height;
    CGFloat width = height * image.size.width / image.size.height;
    CGRect bounds = CGRectMake(x,y,width,height);
    
    self.pickedImage.frame = bounds;
    self.pickedImage.image = image;    
    
    
    UIViewController *viewcon = [self firstAvailableUIViewController];
    [viewcon dismissModalViewControllerAnimated:YES];
    
}



@end
