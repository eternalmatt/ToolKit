//
//  VideoPlayerViewController.h
//  ToolKit
//
//  Created by Matt Senn on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoPlayerView.h"

@interface VideoPlayerViewController : UIViewController

@property (nonatomic, strong) AVPlayer *player;
@property (strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) VideoPlayerView *playerView;
@property (nonatomic, strong) UIButton *playButton;

-(void)loadAssetFromFile:(id)sender;
-(void)play:(id)sender;
-(void)syncUI;

@end
