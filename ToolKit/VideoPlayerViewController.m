//
//  VideoPlayerViewController.m
//  ToolKit
//
//  Created by Matt Senn on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VideoPlayerViewController.h"

@implementation VideoPlayerViewController
@synthesize player, playerItem, playerView, playButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ( self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) 
    {
        // Custom initialization
    }
    return self;
}

-(void)syncUI
{
    playButton.enabled = player.currentItem.status == AVPlayerItemStatusReadyToPlay;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self syncUI];
}

-(void)play:(id)sender
{
    
}

-(void)loadAssetFromFile:(id)sender
{
    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"file" withExtension:@".mov"];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    NSString *tracksKey = @"tracks";
    
    [asset loadValuesAsynchronouslyForKeys:[NSArray arrayWithObject:tracksKey] completionHandler:^{
        
        //static const NSString *ItemStatusContext;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSError *error = nil;
            AVKeyValueStatus status = [asset statusOfValueForKey:tracksKey error:&error];
            
            if (status == AVKeyValueStatusLoaded)
            {
                self.playerItem = [AVPlayerItem playerItemWithAsset:asset];
                [playerItem addObserver:self forKeyPath:@"status" options:0 context:nil];//&ItemStatusContext];
                [[NSNotificationCenter defaultCenter] addObserver:self 
                                                         selector:@selector(playerItemDidReachEnd:) 
                                                             name:AVPlayerItemDidPlayToEndTimeNotification 
                                                           object:playerItem];
                self.player = [AVPlayer playerWithPlayerItem:playerItem];
                [playerView setPlayer:player];
            }
            else
            {
                NSLog(@"The asset's tracks were not loaded:\n%@", error.localizedDescription);
            }
        });
    }];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
}




@end
