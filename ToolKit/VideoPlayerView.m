//
//  VideoPlayerView.m
//  ToolKit
//
//  Created by Matt Senn on 2/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VideoPlayerView.h"

@implementation VideoPlayerView


+(Class)layerClass
{
    return [AVPlayerLayer class];
}

-(AVPlayer*)player
{
    return [(AVPlayerLayer*)[self layer] player];
}

-(void)setPlayer:(AVPlayer *)aPlayer
{
    [(AVPlayerLayer*)[self layer] setPlayer:aPlayer];
}



- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        
        
    }
        
    return self;
}


@end
