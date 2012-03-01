//
//  AccelerationViewController.h
//  ToolKit
//
//  Created by Matt Senn on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

@interface AccelerationView : UIView
< UIAccelerometerDelegate >
{
    @private
    NSMutableArray *accelerationData;
}

@property (weak, nonatomic, readonly, getter=accelerationData) NSArray *data;

@end
