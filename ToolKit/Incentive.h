//
//  Incentive.h
//  ToolKit
//
//  Created by Matt Senn on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Incentive : NSObject

/* I'm not really sure what should make up an Incentive... */

/* These are default properties to describe an incentive.
 * They can and should be completely changed to fit a real incentive */
@property (nonatomic, strong) NSNumber *points;
@property (nonatomic, strong) NSString *purpose;
@property (nonatomic, strong) NSString *campaign;

-(id)initWithPoints:(NSNumber*)points
        withPurpose:(NSString*)purpose 
        andCampaign:(NSString*)campaign;

/* override NSObject's description method to describe this incentive*/
-(NSString*)description;

@end
