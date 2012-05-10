//
//  Incentive.m
//  ToolKit
//
//  Created by Matt Senn on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Incentive.h"

@implementation Incentive
@synthesize points = _points;
@synthesize purpose = _purpose;
@synthesize campaign = _campaign;

-(NSString*)description
{
    return [NSString stringWithFormat:@"Points: %d, purpose: %@, campaign: %@",
            self.points, 
            self.purpose,
            self.campaign];
}

-(id)initWithPoints:(NSNumber*)points
        withPurpose:(NSString*)purpose 
        andCampaign:(NSString*)campaign
{
    if (self = [super init])
    {
        self.points = points;
        self.purpose = purpose;
        self.campaign = campaign;
    }
    return self;
}

@end
